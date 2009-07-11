require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "映画情報を取得した場合" do
  before(:all) do
    @data = Movie.get_movie_info
  end

  it "取得した配列の要素が3つであること" do
    @data.size.should == 3
  end

  it "配列の要素は全て空ではないこと" do
    @data[:urls].size.should_not   == []
    @data[:titles].size.should_not == []
    @data[:infos].size.should_not  == []
  end

  it "取得した画像データをローカルに保存できること" do
    Movie.store_image(@data[:urls]).should be_true
  end

  it "データが正しく保存されること" do
    Movie.store_in_db(@data).should be_true
  end
end
