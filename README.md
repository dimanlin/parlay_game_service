Как установить

1.
Добавляем в Gemfile
gem 'parlay_game_service', path: '../parlay_game_service'

2.
bundle exec rails g parlay_game_service:install
Должен быть создан гонфиг:
config/initializers/parlay_game_service_config.rb
Редактируем полученный конфиг

Как использовать

a = ParlayGameService::Proxy.new({'debug' => true})
# debug - default eq false
a.LoginAction({'user_id' => "OGS12345", 'session_id' => '354252352435', 'password' => "dummy"})

 => {"results"=>{"metadata"=>{"column"=>[{"datatype"=>"text", "name"=>"userId"}, {"datatype"=>"text", "name"=>"token"}, {"datatype"=>"text", "name"=>"authenticated"}, {"datatype"=>"text", "name"=>"jsessionid"}, {"datatype"=>"text", "name"=>"message"}, {"datatype"=>"text", "name"=>"status"}, {"datatype"=>"text", "name"=>"gameServerUrl"}, {"datatype"=>"text", "name"=>"lastLogin"}, {"datatype"=>"text", "name"=>"alias"}]}, "rows"=>{"row"=>{"alias"=>"slake1", "authenticated"=>"true", "gameServerUrl"=>"http://blws1.parlaygames.net", "jsessionid"=>"93B4194D51DADC2F1265FE3957E8F252", "lastLogin"=>"1379924180853", "message"=>"", "status"=>"A", "token"=>"93B4194D51DADC2F1265FE3957E8F252", "userId"=>"OGS12345"}}}}

Запрос от лица суперпользователя:
a.AccountcreateAction({'user_id' => "1234", 'alias' => "iuaysidus", 'first_name' => "asd", 'last_name' => "oaisdo", 'address1' => "a98s7d9as8d", 'city' => "Tmb", 'phone_number' => "09842039", 'country' => 'Rus', 'currency' => 'LAL', 'language' => "ru"}, true)

Второй агрумент "true" означает что в основной запрос будудут добавленны дополнительные аргументы {'admin_user_name' => "******", 'admin_password' => "******"} взятые из "config/initializers/parlay_game_service_config.rb"


Запросы с сессией пользователя:
a = ParlayGameService::Proxy.new({debug: true, 'jsessionid' => "E3573224B7AA05DC775FFE022F7E025A"})

Экземпляр 'a' будет теперь всегда добавлять к основному запросу наш 'jsessionid'

Несколько примеров для формирования запроса:
/site-api/finishpasswordreset.action - a.FinishpasswordresetAction
/site-api/login.action               - a.LoginAction
/site-api/closeaccount.action        - a.CloseaccountAction
Далее по анологии, смотри документацию

Примеры формирования хеши запроса:
a.AccountcreateAction({'user_id' => "1234", 'alias' => "iuaysidus", 'first_name' => "asd", 'last_name' => "oaisdo", 'address1' => "a98s7d9as8d", 'city' => "Tmb", 'phone_number' => "09842039", 'country' => 'Rus', 'currency' => 'LAL', 'language' => "ru"}, true)

Привидённый пример выше анологичен нижнему примеру(разница в хеше):

a.AccountcreateAction({'userId' => "1234", 'alias' => "iuaysidus", 'firstName' => "asd", 'lastName' => "oaisdo", 'address1' => "a98s7d9as8d", 'city' => "Tmb", 'phoneNumber' => "09842039", 'country' => 'Rus', 'currency' => 'LAL', 'language' => "ru"}, true)


