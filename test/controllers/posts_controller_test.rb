# frozen_string_literal: true

require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get posts_index_url
    assert_response :success
  end

  test 'not authorized wont create posts' do
    get '/posts/new'
    assert_redirected_to root_url
  end

  test 'not authorized user wont edit posts' do
    get '/posts/edit/12'
    assert_redirected_to root_url
  end

  test 'only author of post can edit it' do
    get '/users/sign_in', params: { login: 'Dinislam', password: '123456' }
    get '/posts/edit/12'
    assert_redirected_to root_url
  end
end
