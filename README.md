# syachicky

sorry_yahoo_finance([https://github.com/gogotanaka/sorry_yahoo_finance]())をみたら思いついてしまったので勢いで書いた。反省しかない。

## install
0  
gem install syachicky

1  
doSyachicky.rbに

```ruby
require 'syachicky'

syachicky = Syachicky::Syachicky.new(<証券コードをここに>)
syachicky.dataUpdate()
syachicky.printData('#{syachiku["name"]}, 終値:#{syachiku["finish"]}')
```

などと書く

2  
zloginに

```zsh
[[ -f ~/syachicky/doSyachicky.rb ]] && ruby ~/syachicky/doSyachicky.rb
```

を追加する


以上でログイン時に御社株価その他もろもろが表示されます。
取得は一日一回行います。
