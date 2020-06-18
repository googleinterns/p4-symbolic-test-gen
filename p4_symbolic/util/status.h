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

// This is a test file for our protobuf specifications of bmv2 json.
// It reads an input bmv2 json string (usually the output of p4c) via stdin,
// it parses the string using protobuf, and then dumps the parsed protobuf
// objects using protobuf text format and json.
// The dumps are written to output files whose paths are provided as command
// line arguments.

#ifndef P4_SYMBOLIC_UTIL_STATUS_H_
#define P4_SYMBOLIC_UTIL_STATUS_H_

#include "absl/status/status.h"
#include "google/protobuf/stubs/status.h"

namespace p4_symbolic {
namespace util {

// Transforms protobuf status into semantically equivalent absl status.
absl::Status ProtobufToAbslStatus(const google::protobuf::util::Status& status);

}  // namespace util
}  // namespace p4_symbolic

#endif  // P4_SYMBOLIC_UTIL_STATUS_H_
