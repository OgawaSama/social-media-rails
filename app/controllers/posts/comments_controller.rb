module Posts
    class CommentsController < ApplicationController
        before_action :set_post

        def new
            @comment = @post.comments.new
        end

        def create
            @comment = @post.comments.new(comment_params)
            @comment.user = current_user

            if @comment.save
                redirect_to feed_path
            else
                render :new
            end
        end

        def count 
            @count = Post.comments.count
        end

        private

        def set_post
            @post = Post.find(params[:post_id])
        end

        def comment_params
           params.require(:comment).permit(:content) 
        end
    end
end