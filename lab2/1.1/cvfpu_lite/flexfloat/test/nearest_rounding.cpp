/*
   Copyright 2018 - The OPRECOMP Project Consortium, Alma Mater Studiorum
   Università di Bologna. All rights reserved.

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
*/

#include <gtest/gtest.h>
#include <flexfloat.hpp>
#include <cfenv>
#include <cmath>

namespace {

#ifdef FLEXFLOAT_ROUNDING

TEST(FlexFloatNearestRoundingTest, Denormal1Bit) {
    fesetround(FE_TONEAREST);
    const double val = 0.125;
    flexfloat<3, 3> ff_val;
    ff_val = val;
    EXPECT_EQ("0-000-100", bitstring(ff_val));
}

TEST(FlexFloatNearestRoundingTest, Denormal2Bits) {
    fesetround(FE_TONEAREST);
    const double val = 0.1875;
    flexfloat<3, 3> ff_val;
    ff_val = val;
    EXPECT_EQ("0-000-110", bitstring(ff_val));
}

TEST(FlexFloatNearestRoundingTest, Denormal2BitsNeg) {
    fesetround(FE_TONEAREST);
    const double val = -0.1875;
    flexfloat<3, 3> ff_val;
    ff_val = val;
    EXPECT_EQ("1-000-110", bitstring(ff_val));
}

TEST(FlexFloatNearestRoundingTest, Denormal3Bits) {
    fesetround(FE_TONEAREST);
    const double val = 0.21875;
    flexfloat<3, 3> ff_val;
    ff_val = val;
    EXPECT_EQ("0-000-111", bitstring(ff_val));
}

TEST(FlexFloatNearestRoundingTest, DenormalQuarter) {
    fesetround(FE_TONEAREST);
    const double val = 0.0703125; // 1/16 + 1/128
    flexfloat<3, 3> ff_val;
    ff_val = val;
    EXPECT_EQ("0-000-010", bitstring(ff_val));
}

TEST(FlexFloatNearestRoundingTest, DenormalHalfway) {
    fesetround(FE_TONEAREST);
    const double val = 0.078125; // 1/16 + 1/64
    flexfloat<3, 3> ff_val;
    ff_val = val;
    EXPECT_EQ("0-000-010", bitstring(ff_val));
}

TEST(FlexFloatNearestRoundingTest, DenormalThreeQuarters) {
    fesetround(FE_TONEAREST);
    const double val = 0.0859375; // 1/16 + 3/128
    flexfloat<3, 3> ff_val;
    ff_val = val;
    EXPECT_EQ("0-000-011", bitstring(ff_val));
}

TEST(FlexFloatNearestRoundingTest, DenormalSmallest) {
    fesetround(FE_TONEAREST);
    const double val = 0.03125; // 1/32
    flexfloat<3, 3> ff_val;
    ff_val = val;
    EXPECT_EQ("0-000-001", bitstring(ff_val));
}

TEST(FlexFloatNearestRoundingTest, LessThanDenormalSmallest1) {
    fesetround(FE_TONEAREST);
    const double val = 0.0234375; // 1/32-1/64 = 3/128
    flexfloat<3, 3> ff_val;
    ff_val = val;
    EXPECT_EQ("0-000-001", bitstring(ff_val));
}

TEST(FlexFloatNearestRoundingTest, LessThanDenormalSmallest2) {
    fesetround(FE_TONEAREST);
    const double val = 0.015625; // 1/64
    flexfloat<3, 3> ff_val;
    ff_val = val;
    EXPECT_EQ("0-000-000", bitstring(ff_val));
}

TEST(FlexFloatNearestRoundingTest, LessThanDenormalSmallest3) {
    fesetround(FE_TONEAREST);
    const double val = 1.5625e-08;
    flexfloat<3, 3> ff_val;
    ff_val = val;
    EXPECT_EQ("0-000-000", bitstring(ff_val));
}

TEST(FlexFloatNearestRoundingTest, SmallestDoubleDenormal) {
    fesetround(FE_TONEAREST);
    const double val = -4.94065645841246544176568792868E-324;
    flexfloat<3, 3> ff_val;
    ff_val = val;
    EXPECT_EQ("1-000-000", bitstring(ff_val));
}

TEST(FlexFloatNearestRoundingTest, DoubleDenormal) {
    fesetround(FE_TONEAREST);
    const double val = -1.73833895195875108053924431042E-310;
    flexfloat<3, 3> ff_val;
    ff_val = val;
    EXPECT_EQ("1-000-000", bitstring(ff_val));
}

TEST(FlexFloatNearestRoundingTest, SmallDouble) {
    fesetround(FE_TONEAREST);
    const double val =  1.4013E-45 ;
    flexfloat<3, 3> ff_val;
    ff_val = val;
    EXPECT_EQ("0-000-000", bitstring(ff_val));
}

TEST(FlexFloatNearestRoundingTest, DoubleToApproximate1) {
    fesetround(FE_TONEAREST);
    const double val = 1.47845617925789214;
    flexfloat<3, 3> ff_val;
    ff_val = val;
    EXPECT_EQ("0-011-100", bitstring(ff_val));
}

TEST(FlexFloatNearestRoundingTest, DoubleToApproximate2) {
    fesetround(FE_TONEAREST);
    const double val = 1.9375;
    flexfloat<3, 3> ff_val;
    ff_val = val;
    EXPECT_EQ("0-100-000", bitstring(ff_val));
}

TEST(FlexFloatNearestRoundingTest, DoubleToApproximate3) {
    fesetround(FE_TONEAREST);
    const double val = 12.5;
    flexfloat<3, 3> ff_val;
    ff_val = val;
    EXPECT_EQ("0-110-100", bitstring(ff_val));
}

TEST(FlexFloatNearestRoundingTest, DoubleNeg) {
    fesetround(FE_TONEAREST);
    const double val = -15;
    flexfloat<3, 3> ff_val;
    ff_val = val;
    EXPECT_EQ("1-110-111", bitstring(ff_val));
}

TEST(FlexFloatNearestRoundingTest, RoundToInf) {
    fesetround(FE_TONEAREST);
    const double val = 17;
    flexfloat<3, 3> ff_val;
    ff_val = val;
    EXPECT_EQ("0-111-000", bitstring(ff_val));
}

TEST(FlexFloatNearestRoundingTest, RoundToMinusInf) {
    fesetround(FE_TONEAREST);
    const double val = -17;
    flexfloat<3, 3> ff_val;
    ff_val = val;
    EXPECT_EQ("1-111-000", bitstring(ff_val));
}

TEST(FlexFloatNearestRoundingTest, Nan1) {
    fesetround(FE_TONEAREST);
    const double val = nan("");
    flexfloat<3, 3> ff_val;
    ff_val = val;
    EXPECT_EQ("0-111-100", bitstring(ff_val));
}

#ifdef NAN_NORMALIZATION
TEST(FlexFloatNearestRoundingTest, Nan2) {
    fesetround(FE_TONEAREST);
    const double val = 0.0/0.0;
    flexfloat<3, 3> ff_val;
    ff_val = val;
    EXPECT_EQ("0-111-100", bitstring(ff_val));
}
#endif

TEST(FlexFloatNearestRoundingTest, Inf) {
    fesetround(FE_TONEAREST);
    const double val = 1.0/0.0;
    flexfloat<3, 3> ff_val;
    ff_val = val;
    EXPECT_EQ("0-111-000", bitstring(ff_val));
}

#endif /* FLEXFLOAT_ROUNDING */
} // namespace
