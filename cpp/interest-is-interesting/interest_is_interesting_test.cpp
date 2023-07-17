#include "interest_is_interesting.hpp"
#ifdef EXERCISM_TEST_SUITE
#include <catch2/catch.hpp>
#else
#include "test/catch.hpp"
#endif

TEST_CASE("Minimal first interest rate", "[task1]") {
    const double balance{0};
    const double want{0.5};
    REQUIRE_THAT(interest_is_interesting::interest_rate(balance),
                 Catch::Matchers::WithinRel(want, 0.000001));
}

#if defined(EXERCISM_RUN_ALL_TESTS)

TEST_CASE("Tiny first interest rate", "[task1]") {
    const double balance{0.000001};
    const double want{0.5};
    REQUIRE_THAT(interest_is_interesting::interest_rate(balance),
                 Catch::Matchers::WithinRel(want, 0.000001));
}

TEST_CASE("Maximum first interest rate", "[task1]") {
    const double balance{999.9999};
    const double want{0.5};
    REQUIRE_THAT(interest_is_interesting::interest_rate(balance),
                 Catch::Matchers::WithinRel(want, 0.000001));
}

TEST_CASE("Minimal second interest rate", "[task1]") {
    const double balance{1000.0};
    const double want{1.621};
    REQUIRE_THAT(interest_is_interesting::interest_rate(balance),
                 Catch::Matchers::WithinRel(want, 0.000001));
}

TEST_CASE("Tiny second interest rate", "[task1]") {
    const double balance{1000.0001};
    const double want{1.621};
    REQUIRE_THAT(interest_is_interesting::interest_rate(balance),
                 Catch::Matchers::WithinRel(want, 0.000001));
}

TEST_CASE("Maximum second interest rate", "[task1]") {
    const double balance{4999.9990};
    const double want{1.621};
    REQUIRE_THAT(interest_is_interesting::interest_rate(balance),
                 Catch::Matchers::WithinRel(want, 0.000001));
}

TEST_CASE("Minimal third interest rate", "[task1]") {
    const double balance{5000.0000};
    const double want{2.475};
    REQUIRE_THAT(interest_is_interesting::interest_rate(balance),
                 Catch::Matchers::WithinRel(want, 0.000001));
}

TEST_CASE("Tiny third interest rate", "[task1]") {
    const double balance{5000.0001};
    const double want{2.475};
    REQUIRE_THAT(interest_is_interesting::interest_rate(balance),
                 Catch::Matchers::WithinRel(want, 0.000001));
}

TEST_CASE("Large third interest rate", "[task1]") {
    const double balance{5639998.742909};
    const double want{2.475};
    REQUIRE_THAT(interest_is_interesting::interest_rate(balance),
                 Catch::Matchers::WithinRel(want, 0.000001));
}

TEST_CASE("Rate on minimal negative balance", "[task1]") {
    const double balance{-0.000001};
    const double want{3.213};
    REQUIRE_THAT(interest_is_interesting::interest_rate(balance),
                 Catch::Matchers::WithinRel(want, 0.000001));
}

TEST_CASE("Rate on small negative balance", "[task1]") {
    const double balance{-0.123};
    const double want{3.213};
    REQUIRE_THAT(interest_is_interesting::interest_rate(balance),
                 Catch::Matchers::WithinRel(want, 0.000001));
}

TEST_CASE("Rate on regular negative balance", "[task1]") {
    const double balance{-300.0};
    const double want{3.213};
    REQUIRE_THAT(interest_is_interesting::interest_rate(balance),
                 Catch::Matchers::WithinRel(want, 0.000001));
}

TEST_CASE("Rate on large negative balance", "[task1]") {
    const double balance{-152964.231};
    const double want{3.213};
    REQUIRE_THAT(interest_is_interesting::interest_rate(balance),
                 Catch::Matchers::WithinRel(want, 0.000001));
}

TEST_CASE("Interest on negative balance", "[task2]") {
    const double balance{-10000.0};
    const double want{-321.3};
    REQUIRE_THAT(interest_is_interesting::yearly_interest(balance),
                 Catch::Matchers::WithinRel(want, 0.000001));
}
TEST_CASE("Interest on small balance", "[task2]") {
    const double balance{555.43};
    const double want{2.77715};
    REQUIRE_THAT(interest_is_interesting::yearly_interest(balance),
                 Catch::Matchers::WithinRel(want, 0.000001));
}
TEST_CASE("Interest on medium balance", "[task2]") {
    const double balance{4999.99};
    const double want{81.0498379};
    REQUIRE_THAT(interest_is_interesting::yearly_interest(balance),
                 Catch::Matchers::WithinRel(want, 0.000001));
}
TEST_CASE("Interest on large balance", "[task2]") {
    const double balance{34600.80};
    const double want{856.3698};
    REQUIRE_THAT(interest_is_interesting::yearly_interest(balance),
                 Catch::Matchers::WithinRel(want, 0.000001));
}

TEST_CASE("Annual balance update for empty start balance", "[task3]") {
    const double balance{0.0};
    const double want{0.0000};
    REQUIRE_THAT(interest_is_interesting::annual_balance_update(balance),
                 Catch::Matchers::WithinRel(want, 0.000001));
}

TEST_CASE("Annual balance update for small positive start balance", "[task3]") {
    const double balance{0.000001};
    const double want{0.000001005};
    REQUIRE_THAT(interest_is_interesting::annual_balance_update(balance),
                 Catch::Matchers::WithinRel(want, 0.000001));
}

TEST_CASE("Annual balance update for average positive start balance",
          "[task3]") {
    const double balance{1000.0};
    const double want{1016.210000};
    REQUIRE_THAT(interest_is_interesting::annual_balance_update(balance),
                 Catch::Matchers::WithinRel(want, 0.000001));
}

TEST_CASE("Annual balance update for large positive start balance", "[task3]") {
    const double balance{1000.2001};
    const double want{1016.413343621};
    REQUIRE_THAT(interest_is_interesting::annual_balance_update(balance),
                 Catch::Matchers::WithinRel(want, 0.000001));
}

TEST_CASE("Annual balance update for huge positive start balance", "[task3]") {
    const double balance{898124017.826243404425};
    const double want{920352587.2674429417};
    REQUIRE_THAT(interest_is_interesting::annual_balance_update(balance),
                 Catch::Matchers::WithinRel(want, 0.000001));
}

TEST_CASE("Annual balance update for small negative start balance", "[task3]") {
    const double balance{-0.123};
    const double want{-0.12695199};
    REQUIRE_THAT(interest_is_interesting::annual_balance_update(balance),
                 Catch::Matchers::WithinRel(want, 0.000001));
}

TEST_CASE("Annual balance update for large negative start balance", "[task3]") {
    const double balance{-152964.231};
    const double want{-157878.97174203};
    REQUIRE_THAT(interest_is_interesting::annual_balance_update(balance),
                 Catch::Matchers::WithinRel(want, 0.000001));
}

TEST_CASE("Years before desired balance for small start balance") {
    const double balance{100.0};
    const double target_balance{125.80};
    const int want{47};
    REQUIRE(interest_is_interesting::years_until_desired_balance(
                balance, target_balance) == want);
}
TEST_CASE("Years before desired balance for average start balance") {
    const double balance{1000.0};
    const double target_balance{1100.0};
    const int want{6};
    REQUIRE(interest_is_interesting::years_until_desired_balance(
                balance, target_balance) == want);
}
TEST_CASE("Years before desired balance for large start balance") {
    const double balance{8080.80};
    const double target_balance{9090.90};
    const int want{5};
    REQUIRE(interest_is_interesting::years_until_desired_balance(
                balance, target_balance) == want);
}
TEST_CASE("Years before large difference between start and target balance") {
    const double balance{2345.67};
    const double target_balance{12345.6789};
    const int want{85};
    REQUIRE(interest_is_interesting::years_until_desired_balance(
                balance, target_balance) == want);
}
TEST_CASE("Balance is already above target") {
    const double balance{2345.67};
    const double target_balance{2345.0};
    const int want{0};
    REQUIRE(interest_is_interesting::years_until_desired_balance(
                balance, target_balance) == want);
}
TEST_CASE("Balance is exactly same as target") {
    const double balance{2345.0};
    const double target_balance{2345.0};
    const int want{0};
    REQUIRE(interest_is_interesting::years_until_desired_balance(
                balance, target_balance) == want);
}
TEST_CASE("Result balance would be exactly same as target") {
    const double balance{1000.0};
    const double target_balance{1032.6827641};
    const int want{2};
    REQUIRE(interest_is_interesting::years_until_desired_balance(
                balance, target_balance) == want);
}

#endif
