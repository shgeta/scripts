require 'rubygems'
require "mysql"
require 'pit'


beforpitenv = ENV['EDITOR']
ENV['EDITOR']="vi"
afterpitseteditor = ENV['EDITOR']
config = Pit.get("mysql_test02", :require => {
	"db_host" => "db_host",
	"db_user" => "db_user",
	"db_pass" => "db_pass",
	"db_name" => "db_name"
})
if afterpitseteditor == ENV['EDITOR'] then
  ENV['EDITOR'] = beforpitenv
else
  raise "ENV['EDITOR'] not equal afterpitseteditor.  beforpitenv = #{beforpitenv}"
end


my = Mysql.init()
my.options(Mysql::SET_CHARSET_NAME, "utf8")
db = my.real_connect(config["db_host"], config["db_user"], config["db_pass"],  config["db_name"])
query = "insert into test_datas (col1,col2,created_at)values(?,?,NOW())"
st = db.prepare(query)
(0..100).each do
  ar = Array.new(rand(5))
  (0..ar.size).each{|i| ar[i] = rand(10)}
  ar.uniq!
  rs = st.execute(ar.join(" "),rand(10))
end