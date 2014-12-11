module IoAsk

  class CommentsController < IoAsk::ApplicationController

    before_filter :pre_extend, :pre_load

    def pre_extend
      super
    end

    def pre_load      
      @topic = IoAsk::Topic.find(params[:topic_id]) if params[:topic_id]
      @comment = IoAsk::Comment.find(params[:id]) if params[:id]
    end

    def comment_params
      params.require(:comment).permit(:content, :topic_id, :user_id)
    end


    def create
      @comments = @topic.comments
      @comment = @comments.build(comment_params)
      @comment.user = current_user

      if @comment.save
        anchor = '#comment-' + @comment.id.to_s
        return redirect_to "/ask/topics/#{@topic.id}?page=#{@comments.page.total_pages}" + anchor      
      end

      redirect_to :back
    end


    def edit
    end

    def update
      return redirect_to "/ask/topics/#{@comment.topic.id}" if @comment.update_attributes(comment_params)

      render 'edit'

    end


    def destroy
      return redirect_to "/ask/topics/#{@comment.topic.id}" if @comment.destroy
    end

  end

end