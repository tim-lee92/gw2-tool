require 'rails_helper'

describe PostsController do
  describe 'GET index' do
    it 'sets @posts with posts' do
      lily = Fabricate(:user)
      post1 = Fabricate(:post, user: lily)
      post2 = Fabricate(:post, user: lily)
      post3 = Fabricate(:post, user: lily)
      get :index
      expect(assigns(:posts)).to match_array([post1, post2, post3])
    end
  end

  describe 'GET show' do
    it 'sets @post' do
      lily = Fabricate(:user)
      post = Fabricate(:post, user: lily)
      get :show, params: { id: post.id }
      expect(assigns(:post)).to eq(post)
    end

    it 'sets @comment' do
      lily = Fabricate(:user)
      post = Fabricate(:post, user: lily)
      get :show, params: { id: post.id }
      expect(assigns(:comment)).to be_instance_of(Comment)
    end

    it 'sets @comments' do
      lily = Fabricate(:user)
      post = Fabricate(:post, user: lily)
      comment1 = Fabricate(:comment, user: lily, post: post)
      comment2 = Fabricate(:comment, user: lily, post: post)
      get :show, params: { id: post.id }
      expect(assigns(:comments)).to match_array([comment1, comment2])
    end
  end

  describe 'GET new' do
    context 'for authenticated users' do
      it 'sets @post' do
        session[:user_id] = Fabricate(:user).id
        get :new
        expect(assigns(:post)).to be_instance_of(Post)
      end
    end

    context 'for unauthenticated users' do
      it 'redirects to the posts page' do
        get :new
        expect(response).to redirect_to(posts_path)
      end

      it 'sets the error message' do
        get :new
        expect(flash[:error]).to be_present
      end
    end
  end

  describe 'POST create' do
    context 'for authenticated users with valid inputs' do
      before { session[:user_id] = Fabricate(:user).id }

      it 'creates the post with valid inputs' do
        post :create, params: { post: Fabricate.attributes_for(:post) }
        expect(Post.count).to eq(1)
      end

      it 'creates a post associated with the user' do
        post :create, params: { post: Fabricate.attributes_for(:post) }
        expect(Post.first.user.id).to eq(session[:user_id])
      end

      it 'redirects to the created post page' do
        post :create, params: { post: Fabricate.attributes_for(:post) }
        expect(response).to redirect_to(post_path(Post.first.id))
      end
    end

    context 'for authenticated users with invalid inputs' do
      before { session[:user_id] = Fabricate(:user).id }

      it 'does not create a post' do
        post :create, params: { post: {title: 'Hello"'} }
        expect(Post.count).to eq(0)
      end

      it 'does renders the :new template' do
        post :create, params: { post: {title: 'Hello"'} }
        expect(response).to render_template(:new)
      end

      it 'sets the error message' do
        post :create, params: { post: {title: 'Hello"'} }
        expect(flash[:error]).to be_present
      end
    end

    context 'for unauthenticated users' do
      it 'does not create the post' do
        post :create, params: { post: Fabricate.attributes_for(:post) }
        expect(Post.count).to eq(0)
      end

      it 'redirects to the posts path' do
        post :create, params: { post: Fabricate.attributes_for(:post) }
        expect(response).to redirect_to(posts_path)
      end

      it 'sets the error message' do
        post :create, params: { post: Fabricate.attributes_for(:post) }
        expect(flash[:error]).to be_present
      end
    end
  end

  describe 'DELETE destroy' do
    context 'for authenticated users' do
      let(:lily) { Fabricate(:user) }

      before { session[:user_id] = lily.id }

      it 'removes the post' do
        post = Fabricate(:post, user: lily)
        delete :destroy, params: { id: post.id }
        expect(Post.count).to eq(0)
      end

      it 'removes the correct post' do
        post1 = Fabricate(:post, user: lily)
        post2 = Fabricate(:post, user: lily)
        post3 = Fabricate(:post, user: lily)
        delete :destroy, params: { id: post2 }
        expect(Post.all).to match_array([post1, post3])
      end

      it 'does not remove posts by other users' do
        jacky = Fabricate(:user)
        post1 = Fabricate(:post, user: lily)
        post2 = Fabricate(:post, user: jacky)
        post3 = Fabricate(:post, user: lily)
        delete :destroy, params: { id: post2.id }
        expect(Post.all).to match_array([post1, post2, post3])
      end

      it 'redirects to the posts path' do
        post = Fabricate(:post, user: lily)
        delete :destroy, params: { id: post.id }
        expect(response).to redirect_to(posts_path)
      end

      it 'sets the notice' do
        post = Fabricate(:post, user: lily)
        delete :destroy, params: { id: post.id }
        expect(flash[:notice]).to be_present
      end
    end

    context 'for unauthenticated user' do
      let(:lily) { Fabricate(:user) }
      let(:post) { Fabricate(:post, user: lily) }

      it 'does not delete the post' do
        delete :destroy, params: { id: post.id }
        expect(Post.count).to eq(1)
      end

      it 'redirects to the posts path' do
        delete :destroy, params: { id: post.id }
        expect(response).to redirect_to(posts_path)
      end

      it 'sets the error message' do
        delete :destroy, params: { id: post.id }
        expect(flash[:error]).to be_present
      end
    end
  end
end
