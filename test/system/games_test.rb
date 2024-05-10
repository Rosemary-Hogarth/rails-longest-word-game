require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  test "Going to /new gives us a new random grid to play with" do
    visit new_url
    assert test: "New game"
    # assert_selector "li", count: 10
  end

  test "filling the form with a random word generates a message" do
    visit new_url
    fill_in "word", with: "randomword"
    click_on "Play"
    assert_text "We can't build that word."
  end

  test "filling the form with an invalid word generates a message" do
    visit new_url
    fill_in "word", with: "invalidword"
    click_on "Play"
    assert text "Get a dictionary!"
  end

  test "filling the form with a valid word generates a message" do
    visit new_url
    fill_in "word", with: "validword"
    click_on "Play"
    assert text "Well done!"
  end
end
