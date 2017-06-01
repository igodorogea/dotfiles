1. Prepare system
2. Install LEMP
	2.1. Configure MySQL(MariaDB)
	2.2. Configure PHP-FPM
	2.3. Configure nginx


# Commands
1. nginx:site
	args:
		--site-name
	actions:
		- create folder in /var/www/${site-name}/web
		- create files /var/www/${site-name}/web/{index.html,info.php}
		- create nginx vhost configuraton in /etc/nginx/sites-available/${site-name}.conf
		- create symlink in /etc/nginx/sites-enabled/${site-name}.conf
		- restart nginx

2. typo3:site
	args:
		--site-name
	actions:
	    - create mysql db and user
		- clone TYPO3_Distribution in /var/www/${site-name}
		- run composer install
		- run install setup
		- activate third party extensions
		- activate site-package	
