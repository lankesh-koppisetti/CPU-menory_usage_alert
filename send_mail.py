import smtplib
from email.mime.text import MIMEText

sender = "sender@gmail.com"

# Multiple Recipients
receiver = [
    "receiver@gmail.com"
]

# Gmail App Password
app_password = "mailapppassword"

# Read Alert File
with open("/tmp/cpu_alert.txt", "r") as file:
    body = file.read()

# Create Mail Message
msg = MIMEText(body)

msg["Subject"] = "High CPU Utilization Alert"
msg["From"] = sender

# IMPORTANT FIX
msg["To"] = ", ".join(receiver)

try:
    server = smtplib.SMTP("smtp.gmail.com", 587)

    server.starttls()

    server.login(sender, app_password)

    # Send Mail
    server.sendmail(sender, receiver, msg.as_string())

    server.quit()

    print("Mail Sent Successfully")

except Exception as e:
    print("Error:", e)
