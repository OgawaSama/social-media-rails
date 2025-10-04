module Posts
    class CommentsController < ApplicationController
        def new; end

        def create
            @comment = current_user.comments.create(post: @post, name: params[:name])
            @comment.user = current_user
            @comment.update(comment_params)
            redirect_to feed_path
        end

        def count 
            @count = Post.comments.count
        end

        private

        def comment_params
           params.require(:comment).permit(:content) 
        end
    end
end