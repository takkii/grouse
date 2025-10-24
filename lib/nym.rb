# frozen_string_literal: true

require 'open3'

# CoreNYM version in .env
class CoreNYM
    # current date.
    def self.koyomi
        dt = Time.new.getlocal('+09:00')
        week = %w(日 月 火 水 木 金 土)[dt.wday]
        @himekuri = "#{dt.year}年" + "#{dt.month}月" + "#{dt.day}日" + ' : '.to_s + "#{dt.hour}時"+"#{dt.min}分"+"#{dt.sec}秒" + ' : '.to_s + week + "曜日"
    end

    # libgroonga version in pgroonga
    def self.pg_version
        sql = "SHOW pgroonga.libgroonga_version;"
        query = ActiveRecord::Base.connection.select_all(sql).to_a
        pg_string = (query).to_s.gsub(/[^A-Za-z]/, ' ').rstrip
        pg_number = (query).to_s.gsub(/[^.0-9A-Za-z]/, '').rstrip.delete("A-Za-z").delete_prefix(".").delete_suffix(".")
        @pg_version = pg_string + " " + pg_number
    end

    # version number x.x
    def self.version
        @version = ENV['NYASOCOMSUN_VERSION']
    end

    # rubygems version
    def self.gem_version
        gversion = 'gem -v'
        stdout_rb, stderr_rb, status_rb = Open3.capture3(gversion)
        version = stdout_rb.to_s
    end

    # nyasocom tools core version
    def self.core_version
        '1.1.0'.to_s
    end
end

__END__