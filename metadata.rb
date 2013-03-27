maintainer "Mikhail Pobolovets"
maintainer_email "styx.mp@gmail.com"
license "MIT"
description "Installs and configures RVM, optionally keeping it updated."
version "0.0.1"

recipe "rvm", "Install system-wide RVM"
recipe "rvm::install", "Install a ruby implementation based on attributes"

depends "apt"
depends "build-essential"

%w{debian ubuntu}.each do |os|
  supports os
end
