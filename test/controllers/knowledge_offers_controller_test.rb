require 'test_helper'

class KnowledgeOffersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @knowledge_offer = knowledge_offers(:one)
  end

  test "should get index" do
    get knowledge_offers_url
    assert_response :success
  end

  test "should get new" do
    get new_knowledge_offer_url
    assert_response :success
  end

  test "should create knowledge_offer" do
    assert_difference('KnowledgeOffer.count') do
      post knowledge_offers_url, params: { knowledge_offer: { approved: @knowledge_offer.approved, callback_url: @knowledge_offer.callback_url, description: @knowledge_offer.description, id_str: @knowledge_offer.id_str, project_id: @knowledge_offer.project_id, user_id: @knowledge_offer.user_id } }
    end

    assert_redirected_to knowledge_offer_url(KnowledgeOffer.last)
  end

  test "should show knowledge_offer" do
    get knowledge_offer_url(@knowledge_offer)
    assert_response :success
  end

  test "should get edit" do
    get edit_knowledge_offer_url(@knowledge_offer)
    assert_response :success
  end

  test "should update knowledge_offer" do
    patch knowledge_offer_url(@knowledge_offer), params: { knowledge_offer: { approved: @knowledge_offer.approved, callback_url: @knowledge_offer.callback_url, description: @knowledge_offer.description, id_str: @knowledge_offer.id_str, project_id: @knowledge_offer.project_id, user_id: @knowledge_offer.user_id } }
    assert_redirected_to knowledge_offer_url(@knowledge_offer)
  end

  test "should destroy knowledge_offer" do
    assert_difference('KnowledgeOffer.count', -1) do
      delete knowledge_offer_url(@knowledge_offer)
    end

    assert_redirected_to knowledge_offers_url
  end
end
