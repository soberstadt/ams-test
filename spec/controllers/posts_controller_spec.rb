require 'rails_helper'

describe PostsController, type: :controller do
  describe 'show' do
    let!(:post) do
      p = Post.create(title: 'Test Post')
      Comment.create(body: 'this is a comment', post: p)
      p
    end

    it 'with includes' do
      get :show, id: post.id, format: :json, include: 'comments'
      json = JSON.parse(response.body)
      expect(json['data']['relationships']['comments']['data'].length).to be 1

      get :show, id: post.id, include: ''
      json = JSON.parse(response.body)
      relationships = json['data'].try(:[], 'relationships') || {}
      expect(relationships).to_not include 'comments'
    end
  end
end
