require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "ネタバレ情報を取得する場合" do
  before do
  end

  it "Amazon Werb APIを使ってデータが取得出来たとき" do
    Netabare.get_amazon_data()
  end

  it "Amazon Werb APIを使ってデータが取得出来なかったとき" do
    Netabare.get_amazon_data()
  end
end
