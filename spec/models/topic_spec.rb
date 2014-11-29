require "spec_helper"

describe IoAsk::Topic do

  before {
    @user = FactoryGirl.create(:user)
    @user_1 = FactoryGirl.create(:user)
    @user_2 = FactoryGirl.create(:user)
    @user_3 = FactoryGirl.create(:user)

    @topic = FactoryGirl.create(:topic, :user => @user)
  }

  it "comment_count 正确" do
    expect(@topic.comment_count).to eq(0)
  end

  it "last_comment_user 正确" do
    expect(@topic.last_comment_user).to eq(@user)
  end

  it "last_commented_at 正确" do
    expect(@topic.last_commented_at).to eq(@topic.created_at)
  end

  describe '评论' do
    before {
      Timecop.travel(Time.now - 3.day) do
        @comment_1 = FactoryGirl.create(:comment, :topic => @topic, :user => @user_1)
      end

      Timecop.travel(Time.now - 2.day) do
        @comment_2 = FactoryGirl.create(:comment, :topic => @topic, :user => @user_2)
      end

      Timecop.travel(Time.now - 1.day) do
        @comment_3 = FactoryGirl.create(:comment, :topic => @topic, :user => @user_3)
      end
    }

    it "comment_count 正确" do
      expect(@topic.comment_count).to eq(3)
    end

    it "last_comment_user 正确" do
      expect(@topic.last_comment_user).to eq(@user_3)
    end

    it "last_commented_at 正确" do
      expect(@topic.last_commented_at).to eq(@comment_3.created_at)
    end

    describe "删除 comment" do
      before {
        @comment_3.destroy
      }

      it "comment_count 正确" do
        expect(@topic.comment_count).to eq(2)
      end

      it "last_comment_user 正确" do
        expect(@topic.last_comment_user).to eq(@user_2)
      end

      it "last_commented_at 正确" do
        p @comment_1.created_at.to_i
        p @comment_2.created_at.to_i
        p @comment_3.created_at.to_i

        p @topic.last_commented_at.to_i
        p @topic.created_at.to_i

        expect(@topic.last_commented_at.to_i).to eq(@comment_2.created_at.to_i)
      end

    end



    describe "添加 comment" do
      before {
        @user_4 = FactoryGirl.create(:user)
        @comment_4 = FactoryGirl.create(:comment, :topic => @topic, :user => @user_4)
      }

      it "comment_count 正确" do
        expect(@topic.comment_count).to eq(4)
      end

      it "last_comment_user 正确" do
        expect(@topic.last_comment_user).to eq(@user_4)
      end

      it "last_commented_at 正确" do
        expect(@topic.last_commented_at).to eq(@comment_4.created_at)
      end


      describe "删除全部 comment" do
        before {
          @comment_1.destroy
          @comment_2.destroy
          @comment_3.destroy
          @comment_4.destroy
        }

        it "comment_count 正确" do
          expect(@topic.comment_count).to eq(0)
        end

        it "last_comment_user 正确" do
          expect(@topic.last_comment_user).to eq(@user)
        end

        it "last_commented_at 正确" do
          expect(@topic.last_commented_at).to eq(@topic.created_at)
        end
      end

    end

  end

end