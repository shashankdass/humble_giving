require 'test_helper'

class TakersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @taker = takers(:one)
  end

  test "should get index" do
    get takers_url
    assert_response :success
  end

  test "should get new" do
    get new_taker_url
    assert_response :success
  end

  test "should create taker" do
    assert_difference('Taker.count') do
      post takers_url, params: { taker: { country: @taker.country, cross_street1: @taker.cross_street1, cross_street2: @taker.cross_street2, latitude: @taker.latitude, longitude: @taker.longitude, zipcode: @taker.zipcode } }
    end

    assert_redirected_to taker_url(Taker.last)
  end

  test "should show taker" do
    get taker_url(@taker)
    assert_response :success
  end

  test "should get edit" do
    get edit_taker_url(@taker)
    assert_response :success
  end

  test "should update taker" do
    patch taker_url(@taker), params: { taker: { country: @taker.country, cross_street1: @taker.cross_street1, cross_street2: @taker.cross_street2, latitude: @taker.latitude, longitude: @taker.longitude, zipcode: @taker.zipcode } }
    assert_redirected_to taker_url(@taker)
  end

  test "should destroy taker" do
    assert_difference('Taker.count', -1) do
      delete taker_url(@taker)
    end

    assert_redirected_to takers_url
  end
end
