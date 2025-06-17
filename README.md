
### Permissions & Setup

1. **Make the script executable**:

   ```bash
   chmod +x /path/to/randomize_names.sh
   ```

2. **Create the log directory** (if not existing):

   ```bash
   sudo mkdir -p /var/log
   sudo touch /var/log/randomize_names.log
   sudo chmod 664 /var/log/randomize_names.log
   ```

3. **Add cron job** (`crontab -e`):

   ```bash
   0 2 * * * /path/to/randomize_names.sh
   ```

---

### Example Behavior

If a row has:

```
name,email,school
,student@example.com,Falcon Academy
```

…it will be updated to something like:

```
Smith,student@example.com,Falcon Academy
```

…but a row like:

```
Jackson,teacher@example.com,Pine Hill
```

…will be **left untouched**.

---
