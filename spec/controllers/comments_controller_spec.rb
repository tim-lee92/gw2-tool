require 'rails_helper'

describe CommentsController do
  describe 'POST create' do
    context 'with authenticated users' do
      let(:lily) { Fabricate(:user) }
      let(:thread) { Fabricate(:post, user: lily)}

      before do
        session[:user_id] = lily.id
      end

      it 'creates a comment' do
        post :create, params: { comment: Fabricate.attributes_for(:comment), user: lily, post_id: thread.id }
        expect(Comment.count).to eq(1)
      end

      it 'creates a comment associated with the right thread' do
        thread2 = Fabricate(:post, user: lily)
        post :create, params: { comment: Fabricate.attributes_for(:comment), user: lily, post_id: thread.id }
        expect(Comment.first.post).to eq(thread)
      end

      it 'creates a comment associated with the user' do
        post :create, params: { comment: Fabricate.attributes_for(:comment), user: lily, post_id: thread.id }
        expect(Comment.first.user).to eq(lily)
      end

      it 'redirects to the post path' do
        post :create, params: { comment: Fabricate.attributes_for(:comment), user: lily, post_id: thread.id }
        expect(response).to redirect_to(post_path(thread))
      end

      it 'does not create a thread with a blank comment' do
        post :create, params: { comment: { body: nil }, user: lily, post_id: thread.id }
        expect(Comment.count).to eq(0)
      end

      it 'sets the error message with a blank comment' do
        post :create, params: { comment: { body: nil }, user: lily, post_id: thread.id }
        expect(flash[:error]).to be_present
      end
    end

    context 'with unauthenticated users' do
      let(:lily) { Fabricate(:user) }
      let(:thread) { Fabricate(:post, user: lily) }

      it 'redirects to the post path' do
        post :create, params: { comment: Fabricate.attributes_for(:comment), user: lily, post_id: thread.id }
        expect(response).to redirect_to(post_path(thread))
      end

      it 'sets the error message' do
        post :create, params: { comment: Fabricate.attributes_for(:comment), user: lily, post_id: thread.id }
        expect(flash[:error]).to eq('You must be signed in to comment.')
      end
    end
  end
end
