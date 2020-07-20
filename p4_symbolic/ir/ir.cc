// Copyright 2020 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#include "p4_symbolic/ir/ir.h"

#include <string>
#include <unordered_map>
#include <utility>
#include <vector>

#include "absl/strings/match.h"
#include "absl/strings/str_cat.h"
#include "absl/strings/strip.h"
#include "google/protobuf/struct.pb.h"
#include "p4/config/v1/p4info.pb.h"

namespace p4_symbolic {
namespace ir {

namespace {

// Translate a string statement op to its respective enum value.
bmv2::StatementOp StatementOpToEnum(const std::string &op) {
  static std::unordered_map<std::string, bmv2::StatementOp> op_table = {
      {"assign", bmv2::StatementOp::assign}};

  if (op_table.count(op) != 1) {
    return bmv2::StatementOp::unsupported_statement;
  }
  return op_table.at(op);
}

// Translate a string expression type to its respective enum value.
bmv2::ExpressionType ExpressionTypeToEnum(const std::string &type) {
  static std::unordered_map<std::string, bmv2::ExpressionType> type_table = {
      {"field", bmv2::ExpressionType::field},
      {"runtime_data", bmv2::ExpressionType::runtime_data},
      {"hexstr", bmv2::ExpressionType::hexstr_}};

  if (type_table.count(type) != 1) {
    return bmv2::ExpressionType::unsupported_expression;
  }
  return type_table.at(type);
}

// Extracting source code information.
gutil::StatusOr<bmv2::SourceLocation> ExtractSourceLocation(
    google::protobuf::Value unparsed_source_location) {
  if (unparsed_source_location.kind_case() !=
      google::protobuf::Value::kStructValue) {
    return absl::Status(
        absl::StatusCode::kInvalidArgument,
        absl::StrCat("Source Location is expected to be a struct, found ",
                     unparsed_source_location.DebugString()));
  }

  const auto &fields = unparsed_source_location.struct_value().fields();
  if (fields.count("filename") != 1 || fields.count("line") != 1 ||
      fields.count("column") != 1 || fields.count("source_fragment") != 1) {
    return absl::Status(
        absl::StatusCode::kInvalidArgument,
        absl::StrCat("Source Location is expected to contain 'filename', "
                     "'line', 'colmn', and 'source_fragment, found ",
                     unparsed_source_location.DebugString()));
  }

  bmv2::SourceLocation output;
  output.set_filename(fields.at("filename").string_value());
  output.set_line(fields.at("line").number_value());
  output.set_column(fields.at("column").number_value());
  output.set_source_fragment(fields.at("source_fragment").string_value());
  return output;
}

// Parsing and validating Headers.
absl::Status ValidateHeaderTypeFields(const google::protobuf::ListValue &list) {
  // Size must be 3.
  int size = list.values_size();
  if (size != 3) {
    return absl::Status(
        absl::StatusCode::kInvalidArgument,
        absl::StrCat("Header field should contain 3 elements, found ",
                     list.DebugString()));
  }

  // Array must contain [string, int, bool] in that order.
  if (list.values(0).kind_case() != google::protobuf::Value::kStringValue ||
      list.values(1).kind_case() != google::protobuf::Value::kNumberValue ||
      list.values(2).kind_case() != google::protobuf::Value::kBoolValue) {
    return absl::Status(
        absl::StatusCode::kInvalidArgument,
        absl::StrCat("Header field should be [string, int, bool], found ",
                     list.DebugString()));
  }

  return absl::OkStatus();
}

gutil::StatusOr<HeaderType> ExtractHeaderType(const bmv2::HeaderType &header) {
  HeaderType output;
  output.set_name(header.name());
  output.set_id(header.id());
  for (const google::protobuf::ListValue &unparsed_field : header.fields()) {
    RETURN_IF_ERROR(ValidateHeaderTypeFields(unparsed_field));

    HeaderField &field =
        (*output.mutable_fields())[unparsed_field.values(0).string_value()];
    field.set_name(unparsed_field.values(0).string_value());
    field.set_bitwidth(unparsed_field.values(1).number_value());
    field.set_signed_(unparsed_field.values(2).bool_value());
  }

  return output;
}

// Functions for translating values.
gutil::StatusOr<LValue> ExtractLValue(
    const google::protobuf::Value &bmv2_value,
    const std::vector<std::string> &variables) {
  LValue output;
  // Either a field value or a variable.
  if (bmv2_value.kind_case() != google::protobuf::Value::kStructValue ||
      bmv2_value.struct_value().fields().count("type") != 1 ||
      bmv2_value.struct_value().fields().count("value") != 1) {
    return absl::Status(
        absl::StatusCode::kInvalidArgument,
        absl::StrCat("Lvalue must contain 'type' and 'value', found ",
                     bmv2_value.DebugString()));
  }

  const google::protobuf::Struct &struct_value = bmv2_value.struct_value();
  const std::string &type = struct_value.fields().at("type").string_value();
  switch (ExpressionTypeToEnum(type)) {
    case bmv2::ExpressionType::field: {
      const google::protobuf::ListValue &names =
          struct_value.fields().at("value").list_value();

      FieldValue *field_value = output.mutable_field_value();
      field_value->set_header_name(names.values(0).string_value());
      field_value->set_field_name(names.values(1).string_value());
      break;
    }
    case bmv2::ExpressionType::runtime_data: {
      int variable_index = struct_value.fields().at("value").number_value();

      Variable *variable = output.mutable_variable_value();
      variable->set_name(variables[variable_index]);
      break;
    }
    default:
      return absl::Status(
          absl::StatusCode::kUnimplemented,
          absl::StrCat("Unsupported lvalue ", bmv2_value.DebugString()));
  }

  return output;
}

gutil::StatusOr<RValue> ExtractRValue(
    const google::protobuf::Value &bmv2_value,
    const std::vector<std::string> &variables) {
  // TODO(babman): Support the remaining cases: literals and simple expressions.
  RValue output;
  if (bmv2_value.kind_case() != google::protobuf::Value::kStructValue ||
      bmv2_value.struct_value().fields().count("type") != 1 ||
      bmv2_value.struct_value().fields().count("value") != 1) {
    return absl::Status(
        absl::StatusCode::kInvalidArgument,
        absl::StrCat("Rvalue must contain 'type' and 'value', found ",
                     bmv2_value.DebugString()));
  }

  const google::protobuf::Struct &struct_value = bmv2_value.struct_value();
  const std::string &type = struct_value.fields().at("type").string_value();
  switch (ExpressionTypeToEnum(type)) {
    case bmv2::ExpressionType::field: {
      const google::protobuf::ListValue &names =
          struct_value.fields().at("value").list_value();

      FieldValue *field_value = output.mutable_field_value();
      field_value->set_header_name(names.values(0).string_value());
      field_value->set_field_name(names.values(1).string_value());
      break;
    }
    case bmv2::ExpressionType::runtime_data: {
      int variable_index = struct_value.fields().at("value").number_value();

      Variable *variable = output.mutable_variable_value();
      variable->set_name(variables[variable_index]);
      break;
    }
    case bmv2::ExpressionType::hexstr_: {
      HexstrValue *hexstr_value = output.mutable_hexstr_value();
      std::string hexstr = struct_value.fields().at("value").string_value();
      if (absl::StartsWith(hexstr, "-")) {
        hexstr_value->set_value(std::string(absl::StripPrefix(hexstr, "-")));
        hexstr_value->set_negative(true);
      } else {
        hexstr_value->set_value(hexstr);
        hexstr_value->set_negative(false);
      }
      break;
    }
    default:
      return absl::Status(
          absl::StatusCode::kUnimplemented,
          absl::StrCat("Unsupported rvalue ", bmv2_value.DebugString()));
  }

  return output;
}

// Parsing and validating actions.
gutil::StatusOr<Action> ExtractAction(
    const bmv2::Action &bmv2_action,
    const pdpi::IrActionDefinition &pdpi_action) {
  Action output;
  // Definition is copied form pdpi.
  *output.mutable_action_definition() = pdpi_action;

  // Implementation is extracted from bmv2.
  ActionImplementation *action_impl = output.mutable_action_implementation();

  // BMV2 format uses ints as ids for variables.
  // We will replace the ids with the actual variable name.
  std::vector<std::string> variable_map(bmv2_action.runtime_data_size());
  for (int i = 0; i < bmv2_action.runtime_data_size(); i++) {
    const bmv2::VariableDefinition variable = bmv2_action.runtime_data(i);
    (*action_impl->mutable_variables())[variable.name()] = variable.bitwidth();
    variable_map[i] = variable.name();
  }

  // Parse every statement in body.
  // When encoutering a variable, look it up in the variable map.
  for (const google::protobuf::Struct &primitive : bmv2_action.primitives()) {
    if (primitive.fields().count("op") != 1 ||
        primitive.fields().count("parameters") != 1) {
      return absl::Status(absl::StatusCode::kInvalidArgument,
                          absl::StrCat("Primitive statement in action ",
                                       pdpi_action.preamble().name(),
                                       " should contain 'op'"
                                       ", 'parameters', found ",
                                       primitive.DebugString()));
    }

    Statement *statement = action_impl->add_action_body();
    switch (StatementOpToEnum(primitive.fields().at("op").string_value())) {
      case bmv2::StatementOp::assign: {
        AssignmentStatement *assignment = statement->mutable_assignment();
        const google::protobuf::Value &params =
            primitive.fields().at("parameters");
        if (params.kind_case() != google::protobuf::Value::kListValue ||
            params.list_value().values_size() != 2) {
          return absl::Status(absl::StatusCode::kInvalidArgument,
                              absl::StrCat("Assignment statement in action ",
                                           pdpi_action.preamble().name(),
                                           " must contain 2 parameters, found ",
                                           primitive.DebugString()));
        }

        ASSIGN_OR_RETURN(
            *assignment->mutable_left(),
            ExtractLValue(params.list_value().values(0), variable_map));
        ASSIGN_OR_RETURN(
            *assignment->mutable_right(),
            ExtractRValue(params.list_value().values(1), variable_map));
        break;
      }
      default:
        return absl::Status(absl::StatusCode::kUnimplemented,
                            absl::StrCat("Unsupported statement in action ",
                                         pdpi_action.preamble().name(),
                                         ", found ", primitive.DebugString()));
    }

    // Parse source_info struct into its own protobuf.
    // Applies to all types of statements.
    if (primitive.fields().count("source_info") != 1) {
      return absl::Status(
          absl::StatusCode::kInvalidArgument,
          absl::StrCat("Statement in action ", pdpi_action.preamble().name(),
                       " does not have source_info, found ",
                       primitive.DebugString()));
    }

    ASSIGN_OR_RETURN(
        *(statement->mutable_source_info()),
        ExtractSourceLocation(primitive.fields().at("source_info")));
  }

  return output;
}

// Parsing and validating tables.
gutil::StatusOr<Table> ExtractTable(const bmv2::Table &bmv2_table,
                                    const pdpi::IrTableDefinition &pdpi_table) {
  Table output;
  // Table definition is copied from pdpi.
  *output.mutable_table_definition() = pdpi_table;

  // Table implementation is extracted from bmv2.
  TableImplementation *table_impl = output.mutable_table_implementation();
  switch (bmv2_table.type()) {
    case bmv2::ActionSelectorType::simple:
      table_impl->set_action_selector_type(TableImplementation::SIMPLE);
      break;
    case bmv2::ActionSelectorType::indirect:
      table_impl->set_action_selector_type(TableImplementation::INDIRECT);
      break;
    case bmv2::ActionSelectorType::indirect_ws:
      table_impl->set_action_selector_type(TableImplementation::INDIRECT_WS);
      break;
    default:
      return absl::Status(absl::StatusCode::kUnimplemented,
                          absl::StrCat("Unsupported action selector type in ",
                                       bmv2_table.DebugString()));
  }

  return output;
}

}  // namespace

// Main Translation function.
gutil::StatusOr<P4Program> Bmv2AndP4infoToIr(const bmv2::P4Program &bmv2,
                                             const pdpi::IrP4Info &pdpi) {
  P4Program output;

  // Translate headers.
  for (const bmv2::HeaderType &unparsed_header : bmv2.header_types()) {
    ASSIGN_OR_RETURN((*output.mutable_headers())[unparsed_header.name()],
                     ExtractHeaderType(unparsed_header));
  }

  // In reality, pdpi.actions_by_name is keyed on aliases and
  // not fully qualified names.
  std::unordered_map<std::string, const pdpi::IrActionDefinition &>
      actions_by_qualified_name;
  const auto &pdpi_actions = pdpi.actions_by_name();
  for (const auto &[_, action] : pdpi_actions) {
    const std::string &name = action.preamble().name();
    actions_by_qualified_name.insert({name, action});
  }

  // Translate actions.
  for (const bmv2::Action &bmv2_action : bmv2.actions()) {
    const std::string &action_name = bmv2_action.name();

    // Matching action should exist in p4info, unless if this is some implicit
    // action. For example, an action that is automatically generated to
    // correspond to an if statement branch.
    pdpi::IrActionDefinition pdpi_action;
    if (actions_by_qualified_name.count(action_name) != 1) {
      // Fill in the fully qualified action name.
      pdpi_action.mutable_preamble()->set_name(action_name);

      // Fill in the action parameters.
      auto *params_by_id = pdpi_action.mutable_params_by_id();
      auto *params_by_name = pdpi_action.mutable_params_by_name();
      for (int i = 0; i < bmv2_action.runtime_data_size(); i++) {
        const bmv2::VariableDefinition &bmv2_parameter =
            bmv2_action.runtime_data(i);

        p4::config::v1::Action::Param *pdpi_parameter =
            (*params_by_id)[i + 1].mutable_param();
        pdpi_parameter->set_id(i + 1);
        pdpi_parameter->set_name(bmv2_parameter.name());
        pdpi_parameter->set_bitwidth(bmv2_parameter.bitwidth());

        *(*params_by_name)[bmv2_parameter.name()].mutable_param() =
            *pdpi_parameter;
      }
    } else {
      // Safe, no exception.
      pdpi_action = actions_by_qualified_name.at(action_name);
    }

    ASSIGN_OR_RETURN((*output.mutable_actions())[pdpi_action.preamble().name()],
                     ExtractAction(bmv2_action, pdpi_action));
  }

  // Similarly, pdpi.tables_by_name is keyed on aliases.
  std::unordered_map<std::string, const pdpi::IrTableDefinition &>
      tables_by_qualified_name;
  for (const auto &[_, table] : pdpi.tables_by_name()) {
    const std::string &name = table.preamble().name();
    tables_by_qualified_name.insert({name, table});
  }

  // Translate tables.
  for (const auto &pipeline : bmv2.pipelines()) {
    for (const bmv2::Table &bmv2_table : pipeline.tables()) {
      const std::string &table_name = bmv2_table.name();

      // Matching table should exist in p4info, unless if this is some implicit
      // table. For example, a table that is automatically generated to
      // correspond to a conditional.
      pdpi::IrTableDefinition pdpi_table;
      if (tables_by_qualified_name.count(table_name) != 1) {
        // Set table fully qualified name.
        pdpi_table.mutable_preamble()->set_name(table_name);

        // Fill in match field maps.
        auto *match_fields_by_id = pdpi_table.mutable_match_fields_by_id();
        auto *match_fields_by_name = pdpi_table.mutable_match_fields_by_name();
        for (int i = 0; i < bmv2_table.key_size(); i++) {
          const bmv2::TableKey &key = bmv2_table.key(i);

          p4::config::v1::MatchField *match_field =
              (*match_fields_by_id)[i + 1].mutable_match_field();
          match_field->set_id(i + 1);
          match_field->set_name(key.name());
          switch (key.match_type()) {
            case bmv2::TableMatchType::exact: {
              match_field->set_match_type(p4::config::v1::MatchField::EXACT);
              break;
            }
            default:
              return absl::Status(
                  absl::StatusCode::kUnimplemented,
                  absl::StrCat("Unsupported match type ", key.DebugString(),
                               " in table", table_name));
          }

          *(*match_fields_by_name)[key.name()].mutable_match_field() =
              *match_field;
        }
      } else {
        // Safe, no exception.
        pdpi_table = tables_by_qualified_name.at(table_name);
      }

      ASSIGN_OR_RETURN((*output.mutable_tables())[pdpi_table.preamble().name()],
                       ExtractTable(bmv2_table, pdpi_table));
    }
  }

  // Find init_table.
  if (bmv2.pipelines_size() < 1) {
    return absl::Status(absl::StatusCode::kInvalidArgument,
                        "BMV2 file contains no pipelines!");
  }
  output.set_initial_table(bmv2.pipelines(0).init_table());
  return output;
}

}  // namespace ir
}  // namespace p4_symbolic
