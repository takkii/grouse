# frozen_string_literal: true

require 'open3'
require 'socket'
require 'tanraku'

# module grouse many functions.
module Grouse
  module_function

  def udp_socket
    udp = UDPSocket.new
    udp.connect("128.0.0.0", 7)
    adrs = Socket.unpack_sockaddr_in(udp.getsockname)[1]
    udp.close
    adrs
  end

  def list_socket
    Socket.ip_address_list.find do |intf|
      intf.ipv4? && !intf.ipv4_loopback? && !intf.ipv4_multicast?
    end.ip_address
  end

  def eq_socket
    Socket.ip_address_list.find do |ai|
      ai.ipv4? && !ai.ipv4_loopback?
    end.ip_address
  end

  def koyomi
    dt = Time.new.getlocal('+09:00')
    week = %w(日 月 火 水 木 金 土)[dt.wday]
    @himekuri = "#{dt.year}年" + "#{dt.month}月" + "#{dt.day}日" + ' : '.to_s + "#{dt.hour}時"+"#{dt.min}分"+"#{dt.sec}秒" + ' : '.to_s + week + "曜日"
  end

  # libgroonga version in pgroonga
  def pg_version
    sql = "SHOW pgroonga.libgroonga_version;"
    query = ActiveRecord::Base.connection.select_all(sql).to_a
    pg_string = (query).to_s.gsub(/[^A-Za-z]/, ' ').rstrip
    pg_number = (query).to_s.gsub(/[^.0-9A-Za-z]/, '').rstrip.delete("A-Za-z").delete_prefix(".").delete_suffix(".")
    @pg_version = pg_string + " " + pg_number
  end

  # version number x.x
  def version
    @version = ENV['NYASOCOMSUN_VERSION']
  end

  # Using, rubygems version
  def gem_version
    gversion = 'gem -v'
    stdout_rb, stderr_rb, status_rb = Open3.capture3(gversion)
    version = stdout_rb.to_s
  end

    # BrokenCircuit
  def recommender_circuit(number_failures, within_times)
    @num_failures = number_failures
    @within = within_times
    @failures = [].to_s

    if @failures >= @num_failures.to_s
      cutoff = Time.now - @within.to_i
      @failures.split.reject!{|t| t < cutoff.to_s}
      return if @failures.length >= @num_failures.to_i
    end

    begin
      yield
    rescue
      @failures.to_i << (Time.now).to_i
      @failures = nil
    end
  end

  def validation_check(card_naming, members_card, equal_password)
    begin
      card_name = card_naming
      memberscard = members_card
      member = File.expand_path(memberscard + card_name)
      eq_pass = equal_password

      unless File.exist?(member)
        puts 'Not found ' + card_name.to_s + ', Exec tanraku.'
        tanraku_execute
      else
        File.open(member) do |f|
          while (name = f.gets)
            name_c = name.chomp
              unless name_c =~ /#{eq_pass}/o
                puts 'No, Match Word in ' + card_name.to_s
                exit!
              else
                puts "Match word contain #{eq_pass} in #{card_name}"
                return
              end
          end
          if f.eof?
            f.close
          elsif !f.eof
            return
          end
        end
      end
    rescue Exception => cep
      puts cep.backtrace
      puts cep.backtrace_locations
      tanraku_execute
    rescue StandardError => a
      puts a.backtrace
      tanraku_execute
    ensure
      GC.auto_compact
    end
  end

  def ipaddress_certification(gs_udp_socket, gs_list_socket)
    begin
      gs_udp_socket = udp_socket
      gs_list_socket = list_socket

      unless "#{gs_udp_socket}" == "#{gs_list_socket}"
        puts "#{gs_udp_socket} == #{gs_list_socket}"
        puts 'Something other than an IP address was matched.'
        return
      else
        puts 'Passed, ip address specification.'
      end
    rescue StandardError => s
      puts s.backtrace
      tanraku_execute
    ensure
      GC.auto_compact
    end
  end

  # grouse version
  def core_version
    '1.1.7.1'.to_s
  end
end

include Grouse

__END__
