# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# hololive channel id
CHANNELS = {
  'UCp6993wxpyDPHUpavwDFqgg' => 'ときのそら',
  'UCDqI2jOz0weumE8s7paEk6g' => 'ロボ子さん',
  'UCFTLzh12_nrtzqBPsTCqenA' => 'アキ・ローゼンタール',
  'UC1CfXB_kRs3C-zaeTG3oGyg' => '赤井はあと',
  'UCdn5BQ06XqgXoAxIhbqw5Rg' => '白上フブキ',
  'UCQ0UDLQCjY0rmuxCDE38FGg' => '夏色まつり',
  'UC1opHUrw8rvnsadT-iGp7Cg' => '湊あくあ',
  'UCXTpFs_3PqI41qX2d9tL2Rw' => '紫咲シオン',
  'UC7fk0CB07ly8oSl0aqKkqFg' => '百鬼あやめ',
  'UC1suqwovbL1kzsoaZgFZLKg' => '癒月ちょこ',
  'UCvzGlP9oQwU--Y0r9id_jnA' => '大空スバル',
  'UC0TXe_LYZ4scaW2XMyi5_kw' => 'AZKi',
  'UCp-5t9SrOQwXMU7iIjQfARg' => '大神ミオ',
  'UC-hM6YJuNYVAmUWxeIr9FeA' => 'さくらみこ',
  'UCvaTdHTWBGv3MKj3KVqJVCw' => '猫又おかゆ',
  'UChAnqc_AY5_I3Px5dig3X1Q' => '戌神ころね',
  'UC5CwaMl1eIgY8h02uZw7u8A' => '星街すいせい',
  'UC1DCedRgGHBdm81E1llLhOQ' => '兎田ぺこら',
  'UCvInZx9h3jC2JzsIzoOebWg' => '不知火フレア',
  'UCdyqAaZDKHXg4Ahi7VENThQ' => '白銀ノエル',
  'UCCzUftO8KOVkV4wQG1vkUvg' => '宝鐘マリン',
  'UCZlDXzGoo7d44bwdNObFacg' => '天音かなた',
  'UCqm3BQLlJfvkTsX_hvm0UmA' => '角巻わため',
  'UC1uv2Oq6kNxgATlCiez59hw' => '常闇トワ',
  'UCa9Y57gfeY0Zro_noHRVrnw' => '姫森ルーナ',
  'UCFKOVgVbGmX65RxO3EtH3iw' => '雪花ラミィ',
  'UCAWSyEs_Io8MtpY3m-zqILA' => '桃鈴ねね',
  'UCUKD-uaobj9jiqB-VXt71mA' => '獅白ぼたん',
  'UCK9V2B22uJYu3N7eR_BT9QA' => '尾丸ポルカ',
  'UCENwRMx5Yh42zWpzURebzTw' => 'ラプラス・ダークネス',
  'UCs9_O1tRPMQTHQ-N_L6FU2g' => '鷹嶺ルイ',
  'UC6eWCld0KwmyHFbAqK3V-Rw' => '博衣こより',
  'UCIBY1ollUsauvVi4hW4cumw' => '沙花叉クロヱ',
  'UC_vMYWcDjmfdpH6r4TTn1MQ' => '風真いろは',
  'UCMGfV7TVTmHhEErVJg1oHBQ' => '火威青',
  'UCWQtYtq9EOB4-I5P-3fh8lA' => '音乃瀬奏',
  'UCtyWhCj3AqKh2dXctLkDtng' => '一条莉々華',
  'UCdXAk5MpyLD8594lm_OvtGQ' => '儒烏風亭らでん',
  'UC1iA6_NT4mtAcIII6ygrvCw' => '轟はじめ',
}

CHANNELS.each do |channel_id, talent_name|
  Channel.find_or_create_by!(channel_id: channel_id, description: talent_name)
end
