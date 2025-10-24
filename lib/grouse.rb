# frozen_string_literal: true

require 'socket'

# module grouse function.
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
end

include Grouse

__END__