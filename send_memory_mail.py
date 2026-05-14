import smtplib
from email.mime.text import MIMEText

sender = "sender@gmail.com"

receivers = [
    "receiver@gmail.com"
]

# Gmail App Password
app_password = "mailapppass"

# Read Memory Alert File
with open("/tmp/memory_alert.txt", "r") as file:
    body = file.read()

msg = MIMEText(body)

msg["Subject"] = "High Memory Utilization Alert"
msg["From"] = sender
msg["To"] = ", ".join(receivers)

try:
    server = smtplib.SMTP("smtp.gmail.com", 587)

    server.starttls()

    server.login(sender, app_password)

    server.sendmail(sender, receivers, msg.as_string())

    server.quit()

    print("Memory Alert Mail Sent Successfully")

except Exception as e:
    print("Error:", e)
