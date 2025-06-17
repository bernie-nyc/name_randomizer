Permissions & Setup
Make the script executable:

bash
Copy
Edit
chmod +x /path/to/randomize_names.sh
Create the log directory (if not existing):

bash
Copy
Edit
sudo mkdir -p /var/log
sudo touch /var/log/randomize_names.log
sudo chmod 664 /var/log/randomize_names.log
Add cron job (crontab -e):

bash
Copy
Edit
0 2 * * * /path/to/randomize_names.sh
✅ Example Behavior
If a row has:

css
Copy
Edit
name,email,school
,student@example.com,Falcon Academy
…it will be updated to something like:

css
Copy
Edit
Smith,student@example.com,Falcon Academy
…but a row like:

css
Copy
Edit
Jackson,teacher@example.com,Pine Hill
…will be left untouched.
