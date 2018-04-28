require 'test_helper'

class GiversControllerTest < ActionDispatch::IntegrationTest
  setup do
    @giver = givers(:one)
  end

  test "should get index" do
    get givers_url
    assert_response :success
  end

  test "should get new" do
    get new_giver_url
    assert_response :success
  end

  test "should create giver" do
    assert_difference('Giver.count') do
      post givers_url, params: { giver: { country: @giver.country, cross_street1: @giver.cross_street1, cross_street2: @giver.cross_street2, latitude: @giver.latitude, longitude: @giver.longitude, zipcode: @giver.zipcode } }
    end

    assert_redirected_to giver_url(Giver.last)
  end

  test "should show giver" do
    get giver_url(@giver)
    assert_response :success
  end

  test "should get edit" do
    get edit_giver_url(@giver)
    assert_response :success
  end

  test "should update giver" do
    patch giver_url(@giver), params: { giver: { country: @giver.country, cross_street1: @giver.cross_street1, cross_street2: @giver.cross_street2, latitude: @giver.latitude, longitude: @giver.longitude, zipcode: @giver.zipcode } }
    assert_redirected_to giver_url(@giver)
  end

  test "should destroy giver" do
    assert_difference('Giver.count', -1) do
      delete giver_url(@giver)
    end

    assert_redirected_to givers_url
  end
end
