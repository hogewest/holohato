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
  'UCp6993wxpyDPHUpavwDFqgg' => { 'title' => 'SoraCh. ときのそらチャンネル', 'description' => 'ときのそら' },
  'UCDqI2jOz0weumE8s7paEk6g' => { 'title' => 'Roboco Ch. - ロボ子', 'description' => 'ロボ子さん' },
  'UCFTLzh12_nrtzqBPsTCqenA' => { 'title' => 'アキロゼCh。Vtuber/ホロライブ所属', 'description' => 'アキ・ローゼンタール' },
  'UC1CfXB_kRs3C-zaeTG3oGyg' => { 'title' => 'HAACHAMA Ch 赤井はあと', 'description' => '赤井はあと' },
  'UCdn5BQ06XqgXoAxIhbqw5Rg' => { 'title' => 'フブキCh。白上フブキ', 'description' => '白上フブキ' },
  'UCQ0UDLQCjY0rmuxCDE38FGg' => { 'title' => 'Matsuri Channel 夏色まつり', 'description' => '夏色まつり' },
  'UC7fk0CB07ly8oSl0aqKkqFg' => { 'title' => 'Nakiri Ayame Ch. 百鬼あやめ', 'description' => '百鬼あやめ' },
  'UC1suqwovbL1kzsoaZgFZLKg' => { 'title' => 'Choco Ch. 癒月ちょこ', 'description' => '癒月ちょこ' },
  'UCvzGlP9oQwU--Y0r9id_jnA' => { 'title' => 'Subaru Ch. 大空スバル', 'description' => '大空スバル' },
  'UC0TXe_LYZ4scaW2XMyi5_kw' => { 'title' => 'AZKi Channel', 'description' => 'AZKi' },
  'UCp-5t9SrOQwXMU7iIjQfARg' => { 'title' => 'Mio Channel 大神ミオ', 'description' => '大神ミオ' },
  'UC-hM6YJuNYVAmUWxeIr9FeA' => { 'title' => 'Miko Ch. さくらみこ', 'description' => 'さくらみこ' },
  'UCvaTdHTWBGv3MKj3KVqJVCw' => { 'title' => 'Okayu Ch. 猫又おかゆ', 'description' => '猫又おかゆ' },
  'UChAnqc_AY5_I3Px5dig3X1Q' => { 'title' => 'Korone Ch. 戌神ころね', 'description' => '戌神ころね' },
  'UC5CwaMl1eIgY8h02uZw7u8A' => { 'title' => 'Suisei Channel', 'description' => '星街すいせい' },
  'UC1DCedRgGHBdm81E1llLhOQ' => { 'title' => 'Pekora Ch. 兎田ぺこら', 'description' => '兎田ぺこら' },
  'UCvInZx9h3jC2JzsIzoOebWg' => { 'title' => 'Flare Ch. 不知火フレア', 'description' => '不知火フレア' },
  'UCdyqAaZDKHXg4Ahi7VENThQ' => { 'title' => 'Noel Ch. 白銀ノエル', 'description' => '白銀ノエル' },
  'UCCzUftO8KOVkV4wQG1vkUvg' => { 'title' => 'Marine Ch. 宝鐘マリン', 'description' => '宝鐘マリン' },
  'UCZlDXzGoo7d44bwdNObFacg' => { 'title' => 'Kanata Ch. 天音かなた', 'description' => '天音かなた' },
  'UCqm3BQLlJfvkTsX_hvm0UmA' => { 'title' => 'Watame Ch. 角巻わため', 'description' => '角巻わため' },
  'UC1uv2Oq6kNxgATlCiez59hw' => { 'title' => 'Towa Ch. 常闇トワ', 'description' => '常闇トワ' },
  'UCa9Y57gfeY0Zro_noHRVrnw' => { 'title' => 'Luna Ch. 姫森ルーナ', 'description' => '姫森ルーナ' },
  'UCFKOVgVbGmX65RxO3EtH3iw' => { 'title' => 'Lamy Ch. 雪花ラミィ', 'description' => '雪花ラミィ' },
  'UCAWSyEs_Io8MtpY3m-zqILA' => { 'title' => 'Nene Ch.桃鈴ねね', 'description' => '桃鈴ねね' },
  'UCUKD-uaobj9jiqB-VXt71mA' => { 'title' => 'Botan Ch.獅白ぼたん', 'description' => '獅白ぼたん' },
  'UCK9V2B22uJYu3N7eR_BT9QA' => { 'title' => 'Polka Ch. 尾丸ポルカ', 'description' => '尾丸ポルカ' },
  'UCENwRMx5Yh42zWpzURebzTw' => { 'title' => 'Laplus ch. ラプラス・ダークネス - holoX -', 'description' => 'ラプラス・ダークネス' },
  'UCs9_O1tRPMQTHQ-N_L6FU2g' => { 'title' => 'Lui ch. 鷹嶺ルイ - holoX -', 'description' => '鷹嶺ルイ' },
  'UC6eWCld0KwmyHFbAqK3V-Rw' => { 'title' => 'Koyori ch. 博衣こより - holoX -', 'description' => '博衣こより' },
  'UC_vMYWcDjmfdpH6r4TTn1MQ' => { 'title' => 'Iroha ch. 風真いろは - holoX -', 'description' => '風真いろは' },
  'UCMGfV7TVTmHhEErVJg1oHBQ' => { 'title' => 'Ao Ch. 火威青 ‐ ReGLOSS', 'description' => '火威青' },
  'UCWQtYtq9EOB4-I5P-3fh8lA' => { 'title' => 'Kanade Ch. 音乃瀬奏 ‐ ReGLOSS', 'description' => '音乃瀬奏' },
  'UCtyWhCj3AqKh2dXctLkDtng' => { 'title' => 'Ririka Ch. 一条莉々華 ‐ ReGLOSS', 'description' => '一条莉々華' },
  'UCdXAk5MpyLD8594lm_OvtGQ' => { 'title' => 'Raden Ch. 儒烏風亭らでん ‐ ReGLOSS', 'description' => '儒烏風亭らでん' },
  'UC1iA6_NT4mtAcIII6ygrvCw' => { 'title' => 'Hajime Ch. 轟はじめ ‐ ReGLOSS', 'description' => '轟はじめ' },
  'UC9LSiN9hXI55svYEBrrK-tw' => { 'title' => 'Riona Ch. 響咲リオナ - FLOW GLOW', 'description' => '響咲リオナ' },
  'UCuI_opAVX6qbxZY-a-AxFuQ' => { 'title' => 'Niko Ch. 虎金妃笑虎 - FLOW GLOW', 'description' => '虎金妃笑虎' },
  'UCjk2nKmHzgH5Xy-C5qYRd5A' => { 'title' => 'Su Ch. 水宮枢 - FLOW GLOW', 'description' => '水宮枢' },
  'UCKMWFR6lAstLa7Vbf5dH7ig' => { 'title' => 'Chihaya Ch. 輪堂 千速 - FLOW GLOW', 'description' => '輪堂 千速' },
  'UCGzTVXqMQHa4AgJVJIVvtDQ' => { 'title' => 'Vivi Ch. 綺々羅々ヴィヴィ - FLOW GLOW', 'description' => '綺々羅々ヴィヴィ' },
}

CHANNELS.each do |channel_id, data|
  Channel.find_or_create_by!(channel_id: channel_id, title: data['title'], description: data['description'])
end
