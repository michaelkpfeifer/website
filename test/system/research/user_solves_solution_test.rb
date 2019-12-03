require_relative "./test_case"

class Research::UserSolvesSolutionTest < Research::TestCase
  test "user views previous test status" do
    user = create(:user, :onboarded, joined_research_at: 2.days.ago)
    solution = create(:research_experiment_solution, user: user)
    submission = create(:submission, solution: solution)
    create(:submission_test_result,
           submission: submission,
           results_status: "fail",
           tests: [
             {
               "name" => "Test 1",
               "status" => "fail",
               message: "Wrong variable"
             }
           ]
          )

    sign_in!(user)
    visit research_experiment_solution_path(solution)

    assert_text "Failed test: Test 1"
    assert_text "Wrong variable"
  end
end