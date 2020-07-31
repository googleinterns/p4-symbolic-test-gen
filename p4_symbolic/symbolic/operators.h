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

// Defines a wrapper around z3 c++ API operators.
// The wrappers ensure sort compatibility, and pad bitvectors when needed.
// Additionally, they use absl::Status to convey sort compatibility failures
// instead of runtime crashes.

#ifndef P4_SYMBOLIC_SYMBOLIC_OPERATORS_H_
#define P4_SYMBOLIC_SYMBOLIC_OPERATORS_H_

#include "gutil/status.h"
#include "z3++.h"

namespace p4_symbolic {
namespace symbolic {
namespace operators {

// Arithmetic operations.
gutil::StatusOr<z3::expr> Plus(const z3::expr &a, const z3::expr &b);
gutil::StatusOr<z3::expr> Minus(const z3::expr &a, const z3::expr &b);
gutil::StatusOr<z3::expr> Times(const z3::expr &a, const z3::expr &b);

// Relational operations.
gutil::StatusOr<z3::expr> Eq(const z3::expr &a, const z3::expr &b);
gutil::StatusOr<z3::expr> Neq(const z3::expr &a, const z3::expr &b);
gutil::StatusOr<z3::expr> Lt(const z3::expr &a, const z3::expr &b);
gutil::StatusOr<z3::expr> Lte(const z3::expr &a, const z3::expr &b);
gutil::StatusOr<z3::expr> Gt(const z3::expr &a, const z3::expr &b);
gutil::StatusOr<z3::expr> Gte(const z3::expr &a, const z3::expr &b);

// Boolean operations.
gutil::StatusOr<z3::expr> Not(const z3::expr &a);
gutil::StatusOr<z3::expr> And(const z3::expr &a, const z3::expr &b);
gutil::StatusOr<z3::expr> Or(const z3::expr &a, const z3::expr &b);

// Binary operations.
gutil::StatusOr<z3::expr> BitNeg(const z3::expr &a);
gutil::StatusOr<z3::expr> BitAnd(const z3::expr &a, const z3::expr &b);
gutil::StatusOr<z3::expr> BitOr(const z3::expr &a, const z3::expr &b);
gutil::StatusOr<z3::expr> BitXor(const z3::expr &a, const z3::expr &b);
gutil::StatusOr<z3::expr> LShift(const z3::expr &bits, const z3::expr &shift);
gutil::StatusOr<z3::expr> RShift(const z3::expr &bits, const z3::expr &shift);

// If-then-else.
gutil::StatusOr<z3::expr> Ite(const z3::expr &condition,
                              const z3::expr &true_value,
                              const z3::expr &false_value);

// Converts the expression into a semantically equivalent boolean expression.
gutil::StatusOr<z3::expr> ToBoolSort(const z3::expr &a);
gutil::StatusOr<z3::expr> ToBitVectorSort(const z3::expr &a, unsigned int size);

// Prefix equality: this is the basis for evaluating LPMs.
gutil::StatusOr<z3::expr> PrefixEq(const z3::expr &a, const z3::expr &b,
                                   unsigned int prefix_size);

}  // namespace operators
}  // namespace symbolic
}  // namespace p4_symbolic

#endif  // P4_SYMBOLIC_SYMBOLIC_OPERATORS_H_