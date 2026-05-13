import smtplib
from email.mime.text import MIMEText

sender = "k.lankesh33@gmail.com"

receivers = [
    "lankeshkoppisetti033@gmail.com",
    "anushapasumarthi544@gmail.com"
]

# Gmail App Password
app_password = "wawdqehrxlmskdem"

# Read Memory Alert File
with open("/root/mem_usage.sh", "r") as file:
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
