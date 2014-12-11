# encoding: utf-8
module Neo::Config
  @init = {
    :env => 'prod', :default_module => 'site',
    :lang => 'TrTr',
    :routes => {
      :login    => %w( /giris / user:user:login get,post ),
      :profil   => %w( /profil / user:user:index ),
      :logout   => %w( /cikis / user:user:logout ),
      :register => %w( /kayit / user:user:register get,post )
    },
    :asset_sets => {
    },
    :assets => [
      {action: 'user:user:login',
       files: %w(/css/login.css)}
    ],
    :db => {
        :name => 'DbInbiq',
        :port => 7474
    },
    :mail => {
      :from => 'burakdirin@gmail.com',
      :defaults => {
        :address              => 'smtp.gmail.com',
        :port                 => 587,
        :domain               => 'netvent.com',
        :user_name            => 'burak@netvent.com',
        :password             => '14534545',
        :authentication       => :plain,
        :enable_starttls_auto => true
      }
    }
  }
  @prod = {
    :errors => {
      :e404 => ['Main:Errors:e404', {:errMsg => 'Sayfa Bulunamadı'}],
      :e500 => ['Main:Errors:e500', {:errMsg => 'Sunucu Hatası'}]
    }
  }
  @dev = {
    :routes => {
      :dev_page => %w( /merhaba-dev /isim main:main:index get )
    }
  }


end