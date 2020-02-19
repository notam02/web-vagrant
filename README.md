This is a vagrant environment for local wordpress website development setup.

When installed, it will automatically get and install the necessarry packages and programs and set up a virtual Ubuntu 18 machine ready for use. 

# Usage

Get this repo
`git clone https://github.com/notam02/web-vagrant && cd web-vagrant`

Start the VM, this will take the first time because it needs to download and install the VM and software
`vagrant up && vagrant ssh`

Then, in your browser move to `http://192.168.33.21/` which should contain instructions to setup Wordpress.

To change a theme, go back to the folder in which you put the Vagrant environment and find a folder called html. This is the root of the wordpress installation. Navigate to wp-content->themes and download or edit a theme there from the host machine.

# Features
- Wordpress
- PHP, MySQL and Apache
- Node, NPM and Gulp

# Passwords

The MySQL database has the default user/password `root`/`root`, upon installation a database called `wordpress` is setup automatically.
