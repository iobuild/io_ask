module IoAsk
  class TopicsController < IoAsk::ApplicationController



    before_filter :authenticate_user!, 
              :except => [:show, :index]

    before_filter :pre_extend, :pre_load


    def pre_extend
      super
    end

    def pre_load
      @category = nil
      @topic = IoAsk::Topic.find(params[:id]) if params[:id]
      @category = @topic.category if @topic
    end

    def topic_params
      params.require(:topic).permit(:title, :content, :category_id, :user_id)
    end


    def index
      @category = IoAsk::Category.find(params[:cid]) if params[:cid]

      @topics = get_by_last_commented_at(params[:latest], params[:cid])
    end


    def new
      @topic = IoAsk::Topic.new
    end


    def create
      @topic = current_user.topics.build(topic_params)

      return redirect_to "/ask/topics" if @topic.save

      render 'new'
    end

    def show
      @comment = IoAsk::Comment.new

      @comments = @topic.comments.order('id asc').page params[:page]
    end


    def edit
    end

    def update
      return redirect_to "/ask/topics/#{@topic.id}" if @topic.update_attributes(topic_params)

      render 'edit'

    end


    def destroy
      return redirect_to :action => :index if @topic.destroy
    end

    private

      def get_by_last_commented_at(last_commented_at, cid)
        case params[:latest]
        when 'topic'
          return IoAsk::Topic.page params[:page] if cid.nil?
          IoAsk::Topic.by_category(cid).page params[:page]
        when 'comment'
          return IoAsk::Topic.last_commented.page params[:page] if cid.nil?
          IoAsk::Topic.last_commented.by_category(cid).page params[:page]
        else
          return IoAsk::Topic.page params[:page] if cid.nil?
          IoAsk::Topic.by_category(cid).page params[:page]
        end
      end


    
  end

end
