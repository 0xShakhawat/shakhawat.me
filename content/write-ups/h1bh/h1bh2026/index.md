---
title: "HackerOne BUG HUNT Qualifier Report"
date: 2025-11-22T00:00:00+06:00
draft: false
tags: ["bughunt", "hackerone"]
categories: ["HackerOneBugHunt"]
---

# HackerOne Bug Hunt 2026 Qualifiers Report
## ChaBank LTD - Security Vulnerability Report

**Target Application:** ChaBank LTD
**Researcher:** Md. Shakhawat Hossain (0xShakhawat)
**Email:** 0xshakhawat@wearehackerone.com
**Report Date:** 22 November 2025
**Total Vulnerabilities Found:** 12
**Event:** HackerOne Bug Hunt 2026 Qualifiers

---

## Bug #1: Server-Side Template Injection (SSTI) Leading to Remote Code Execution

### Severity
**Critical** | **CVSS 10.0**

### Title
Remote Code Execution via Server-Side Template Injection in Rewards Calculator

### Description
The rewards calculator feature contains a severe Server-Side Template Injection (SSTI) vulnerability in the `expression` parameter. A hidden/disabled input field on the frontend can be enabled and exploited to inject template expressions that are evaluated server-side. Attackers can leverage this to execute arbitrary Python code, leading to complete server compromise with root privileges.

### Vulnerability Type
- Server-Side Template Injection (SSTI)
- Remote Code Execution (RCE)
- Insufficient Input Validation
- Hidden Functionality Exposure

### Affected Endpoint
`POST /calculate-rewards`

### Steps to Reproduce

1. Navigate to the "Calculate Rewards" page

   ![Bug 12 - Image 1](https://blogger.googleusercontent.com/img/a/AVvXsEiyORwXIygxcuFbOg-nIpbZGzkwozGQCkfFNhQ5h8_I47-zJg0bfp8Nnt0RZDbcjTJZt-Ec06bEg_dfjR-2qZYiaBhpQG3dknR5sQPwGStpq2hG0P_dHMuwyzNwSKSG8Hb4hB1EqoN93g2AJ8Xh8MqlvDgDLULfBp8t4eD7bYDUre8zh5D3kX0W-6bvCo4)
   *Rewards calculator form showing various spending categories*

2. Inspect the HTML source code using Developer Tools (F12)
3. Locate the disabled "Custom Expression" input field in the HTML source
4. Note the parameter name: `expression`

   ![Bug 12 - Image 2](https://blogger.googleusercontent.com/img/a/AVvXsEhg5AJDXztc6DYp7Ewb9bG7bCcJJ28CdWM8exVf5oTDuYC2mVZ5rQ8RgV5Nnov-ToqVXSJ3jYFWFqabGvbWIoTRtv4kW1d3FohgjkTbdLWOLh4RntpWX6DnOqslcZKI8HWDMqPXUwMzm52kJkpenZZBjui9OWkC2jBhWvDeaK6jvzZ261mspWtCb0-VFI0)
   *Developer tools showing the disabled input field with name="expression"*

5. Open Burp Suite and enable request interception
6. Fill in the rewards form with sample values:
   - Card Type: Business American Express
   - Dining: 121
   - Groceries: 32
   - Travel: 23
   - Gas & Fuel: 34
   - Other Purchases: 543

7. Click "Calculate Rewards"
8. In Burp Suite, intercept the POST request to `/calculate-rewards`
9. Add the `expression` parameter with SSTI test payload:
   ```
   expression={{7*7}}
   ```

   ![Bug 12 - Image 3](https://blogger.googleusercontent.com/img/a/AVvXsEhYvKR3NiWc4v2IavYTi1gBC4ezfdu31QZ3WThpfCefimG74GNwafVLKBkXhmvU03Y_ID3pE1dHQM3mo2kshWjSnC4TY9kex7OxNQrPGRS7RSjEsuIvjX-rEsHlokQxZY0KvDTbavFMuVxB-STbb3kh0AD-3TEs9h01jDOOKNxyFtSiZ9nb9jUECN_UU-I)
   *Burp Suite request showing the SSTI test payload {{7*7}}*

10. Forward the request and observe the response

    ![Bug 12 - Image 4](https://blogger.googleusercontent.com/img/a/AVvXsEiC8_gMRUgRlJt7Hu-9N5sBwCE64DfmYQ3gxBKzvbIcFzYXlDGb_W-TjnNPPFbYyz3C7glOLF70eOsaKpBUBHcAbE8g5fwXYCgqMyVVWR7BEyYzthie8aQmnJ-UKO4VjU0h5KUOXkEkQ0QdwdXI5lprBCciBU5nzvj8gEL-zOzfw2fo_25dB1bxHQY9OeQ)
    *Response showing "49" confirming template evaluation*

11. Now exploit with OS command injection payload:
    ```
    expression={{cycler.__init__.__globals__.os.popen('id').read()}}
    ```

    ![Bug 12 - Image 5](https://blogger.googleusercontent.com/img/a/AVvXsEh5tAOvdEvTGVdFjit_xHlSUjn40NihZh_oLiwliybrxWkXWJV-KCe6hCSMB__eEdXaof7vISpGaXHyqYgHTIPk2k39nGh9eKftNO2KUVcH5vy4gIVd9EG2tZ0HUXpI5RIuazChbo8Ml4YukMC783VPfPQLwqqvqpOXQIi9RK3XM5TEAuZHevdVlUIWXVg)
    *RCE payload execution showing uid=0(root), gid=0(root), groups=0(root)*

12. Execute arbitrary commands to fully compromise the server

### Impact
- **Complete Server Compromise:** Full remote code execution as root user
- **Data Breach:** Access to entire database with all customer information
- **Financial Theft:** Ability to manipulate all account balances and transactions
- **Ransomware:** Potential to encrypt and hold the entire system hostage
- **Lateral Movement:** Access to internal network and connected systems
- **Backdoor Installation:** Persistent access for future attacks
- **Business Destruction:** Complete loss of system integrity and customer trust
- **Regulatory Catastrophe:** Severe violations of all banking security standards
- **Criminal Investigation:** Likely regulatory and law enforcement involvement

### Recommendation
1. **Immediately disable or remove the Custom Expression functionality**
2. Never evaluate user input as code or templates
3. Use sandboxed environments if dynamic calculations are absolutely necessary
4. Implement strict input validation with allowlists
5. Use static calculation methods rather than dynamic evaluation
6. Run application with minimal privileges (not as root)
7. Implement Web Application Firewall (WAF) with SSTI detection rules
8. Conduct emergency security audit of all user input handling
9. Implement robust logging and intrusion detection systems
10. Consider rewriting the rewards calculator with safe, parameterized calculations

---

## Bug #2: Account Takeover via OTP Leakage in Password Reset Flow

### Severity
**Critical** | **CVSS 10.0**

### Title
Complete Account Takeover Through OTP Disclosure in Password Reset Response

### Description
The password reset functionality contains a critical flaw where the One-Time Password (OTP) is sent in the server's HTTP response to the client, rather than being sent to the user's registered email or phone. An attacker can recover any user's User ID through the "Forgot User ID" feature, then intercept the password reset request to retrieve the OTP directly from the response, allowing complete account takeover without any legitimate credentials.

### Vulnerability Type
- Broken Authentication
- Information Disclosure
- Insufficient OTP Protection
- Account Takeover

### Affected Endpoint
`POST /api/request_password_reset`

### Steps to Reproduce

1. Navigate to the "Forgot User ID / Password" page
2. Click on the "Forgot User ID" tab
3. Enter the victim's account number (e.g., 100141955843)
4. Click "Recover User ID"

   ![Bug 8 - Image 1](https://blogger.googleusercontent.com/img/a/AVvXsEg4qgK_lY6faEm_dtr5g-CF7qa30RYYOhinDKmeBfXvNtDZFgmJmKKelNnY5iHSGdMOU5vtaZCYyf5GoLyqbQV5lDJTSW9589AdAcrZyMFBDAaNT-7OWjaOFUf6NL_wHIEwPiFtw9Zs0EhGhZD1oZXFAeyckpFwFxmSKDAEPLfZTrP7QPpncWoKHph6uW4)
   *Forgot User ID page showing recovered User ID: 1337rce1*

5. The system displays the victim's User ID (e.g., 1337rce1)
6. Switch to the "Forgot Password" tab
7. Enter the recovered User ID (1337rce1)

   ![Bug 8 - Image 2](https://blogger.googleusercontent.com/img/a/AVvXsEjeRUjeU2NoAq-eVpENMVeRnMn5SUCxRKjNOJsGpt9gGMZbsWs4SMipxcrtBHyGvbzBgC2FMXLNcT7pu6cx8xmNQ14McwGaRvpW_mR3nTciNyTmTmYyzBc7pJeiDtirXDf-zjI8UkXDbgqwSaZ3q_ZYOdPWmnv4YM1B88wrRx390XaTy9d4c-Y7yBD6h9s)
   *Forgot Password tab with victim's User ID entered*

8. **Do not click "Send OTP" yet**
9. Open Burp Suite and enable request interception
10. Click "Send OTP"
11. In Burp Suite, examine the POST request to `/api/request_password_reset`
12. Observe the response contains the OTP in plain text:
    ```json
    {
      "user_id": "1337rce1",
      "otp": "620241"
    }
    ```

    ![Bug 8 - Image 3](https://blogger.googleusercontent.com/img/a/AVvXsEjO4Q7mWdYgfwC1EimgXRSejPHIN0zwH7UT8WqEm6foR6TNRNd5Cd75EChyrI-rz6Rn4PBLaGRlZuRn-gaqOwmlgbMs4cLJ6XSTQfDM9bOiqeCWy7WH95jxt7qJcTSkBP9o0QaEVmccwxK4-_2T_0eebYV3jI0GRsalIpp3pqloJpoVLJ4X8NlVNZ9WJGQ)
    *Burp Suite showing OTP (620241) disclosed in the HTTP response*

13. Copy the OTP from the response (620241)
14. In the web interface, paste the OTP
15. Enter a new password of your choice
16. Click "Reset Password"

    ![Bug 8 - Image 4](https://blogger.googleusercontent.com/img/a/AVvXsEhCmvr-TqftzpcoQhDGwrKIAW6H97P0OToIQwWkQerhKrQyRXEzucykQOOfIUVlbNHG1BsUch98BDrZKGPhJ6vResIQlJ_pxAm4p0vLLxbTjSeC0x_gjKPYvd9l82PfnwkILnGR-dXGmkdgzQwu9XS1dCdl8WTrDN76vhDWek0r5ogZsMAeGhhyyCt3Ljc)
    *Password reset form with OTP and new password entered*

17. Successfully log in to the victim's account using the User ID and new password

    ![Bug 8 - Image 5](https://blogger.googleusercontent.com/img/a/AVvXsEifUgQ-ycVefYLE3_pAQ_pX2NryRKAizSvPPqG1u5-i4sx2rdO7iDtqAIIBkF86tEOP_QkZ4jddh50lp87jXbOjiWiI-jj2ZiKl5XhtFIfoUHcIMzoAwv7q-S5vNPPKEkwXrxRr_It7Zt35C-nMfeVliE-hzJsDAlWTLfUV0J2l6xXf7kVTwz7d_R8jfWI)
    *Login page with compromised credentials*

    ![Bug 8 - Image 6](https://blogger.googleusercontent.com/img/a/AVvXsEhJlD7Vv_yNjkmE3qlNO_DFMKWgprGRZlbKSp6AUrw92_7gKbEaAG-4IPSrS8zv0cIUwiXKTAhJpAVqWjHkwnFoqlaYce-sl3oBDfK_7ca0gmqyjdeL1-EmJJNj4ngghszfo2U3XZE-Zjr8FpOSGE73REFjiVRujZ56Le-5van7gcab57lUo_09Bs76iCE)
    *Successfully logged into victim's account dashboard showing account takeover*

### Impact
- **Complete Account Takeover:** Full access to any customer's banking account
- **Financial Theft:** Ability to transfer all funds out of compromised accounts
- **Identity Theft:** Access to personal and financial information
- **Mass Exploitation:** Attackers can automate account takeovers at scale
- **Regulatory Violations:** Severe breach of banking security standards
- **Business Extinction:** Could lead to complete loss of customer trust and business closure
- **Legal Consequences:** Lawsuits, fines, and potential criminal charges

### Recommendation
1. **Never return OTP in HTTP responses** - OTPs should only be sent via out-of-band channels (SMS, email)
2. Implement proper OTP delivery mechanisms using verified contact information
3. Add rate limiting on OTP generation and validation attempts
4. Implement account lockout after multiple failed OTP attempts
5. Use time-limited OTPs (e.g., 5-10 minute expiration)
6. Implement logging and alerting for password reset attempts
7. Add CAPTCHA to prevent automated exploitation
8. Consider implementing multi-factor authentication
9. Validate that the OTP request originates from the legitimate account owner

---

## Bug #3: Self-Transfer Balance Multiplication Exploit

### Severity
**Critical** | **CVSS 9.9**

### Title
Unlimited Balance Generation Through Self-Account Money Transfer

### Description
The ChaBank platform allows users to transfer money to their own account number. Instead of treating this as a no-op transaction, the system incorrectly credits the transfer amount to the user's account without debiting it, effectively multiplying the account balance with each self-transfer. An attacker can exploit this to generate unlimited funds.

### Vulnerability Type
- Business Logic Flaw
- Insufficient Transaction Validation
- Lack of Self-Transfer Protection

### Affected Endpoint
`POST /api/transfer`

### Steps to Reproduce

1. Log in to your ChaBank account
2. From the dashboard, note the current balance (e.g., ৳5,000)
3. Copy your own account number from the dashboard (e.g., 100144712002)

   ![Bug 3 - Image 1](https://blogger.googleusercontent.com/img/a/AVvXsEjV923Yku-WScI-ZbGGjmI3GMEUNlVUHy9dDKBzV--XHDUtCKum-dS9vSPunPudIu38Ho3fbkEp8KTQZ0dE_IyNXu-A7XUuBSwrHgL-OulDKVrdRDOholos8LfZQhNk3Rnp_FLhaV7IwLclyWTj38_HJxh5SswkU_HFF8z310t05ciBn6CDWEDukJ_rEc0)
   *Dashboard showing initial balance of ৳5,000 with account number 100144712002 visible*

   ![Bug 3 - Image 2](https://blogger.googleusercontent.com/img/a/AVvXsEgbGy_1oT0hFaxVGgWEbzIth89HacBbNMwXH7igN_uba0kskuRx7pWaabuJUmXKHShxjACpTrI_8oxSxQEBiHCzCA4qsH4b4G-WPiVU8clSoYa1FVsTQVj0D11gG-aPoZXJ-A3fCdw_iU2w93UDgw-btjAyqrlam_NQoNaUNBR2pPqq7OUxTBmLPkOx9f8)
   *Dashboard with account number highlighted for copying*

4. Navigate to "Transfer Money" from the Quick Actions menu

   ![Bug 3 - Image 3](https://blogger.googleusercontent.com/img/a/AVvXsEh_AwDsSTLf4XLq5rG2ckxTZa5xpnIK-0oetX3ScgbFA_2DupaZAzJ_OusLS9AzDcLx9yqLLsucpmYop1cYPI8x1Ojn2CGFJtNf3QsSIlTuLSz2--SjRAVsY1rRBRyUBIFwSfi7QZyS7esivn7uSE3zqlz5BbtuKmxetxCdsV7AJcc0OE8oIN6Dil63hX8)
   *Quick Actions menu with Transfer Money option highlighted*

5. In the "Recipient Account Number" field, enter **your own account number** (100144712002)
6. Enter a transfer amount (e.g., ৳3,000)
7. Add an optional reference (e.g., "hacktheplanet")
8. Click "Transfer Now"
9. Return to the dashboard
10. Observe that the balance has **increased** by the transfer amount (from ৳5,000 to ৳8,000)

    ![Bug 3 - Image 5](https://blogger.googleusercontent.com/img/a/AVvXsEjySAeFBdVnBEewys_d-v3lLuSbCfAGR5Z-iBpwCwCfSYjQ-xkpwN5H7Ynp0ruK2yDlmLtte20wwzyzOn7-Yoar6f0Sim-oQM39wGabjANsaKE0DZdp2UK97ixe1gkwZdFUsmQAu4SSk7kAsI5r5sL3iIaAhYZB3BCpL-QfxOoknXDzrVkHoCTXapaBEMQ)
    *Dashboard showing increased balance of ৳8,000 after self-transfer*

11. Repeat steps 4-10 to continue multiplying your balance indefinitely

### Impact
- **Critical Financial Loss:** Users can generate unlimited funds without any capital
- **System Integrity:** Complete breakdown of transaction logic and accounting principles
- **Money Laundering Risk:** Could be exploited for sophisticated money laundering schemes
- **Database Corruption:** Artificial inflation of account balances could corrupt financial records
- **Business Collapse:** If exploited at scale, could bankrupt the institution

### Recommendation
1. Implement validation to detect and block self-transfers (source account == destination account)
2. Add business logic to treat self-transfers as null operations with appropriate user messaging
3. Implement proper double-entry bookkeeping where every credit has a corresponding debit
4. Add transaction integrity checks to ensure total system balance remains constant
5. Implement fraud detection for unusual transaction patterns
6. Add audit logging for all transfer operations

---

## Bug #4: Balance Manipulation During Account Creation

### Severity
**Critical** | **CVSS 9.8**

### Title
Arbitrary Account Balance Manipulation via Client-Side Parameter Tampering During Registration

### Description
The ChaBank LTD platform offers a ৳1,000 welcome bonus upon account creation. However, the account balance is controlled by a client-side parameter (`BL`) sent during the registration process. An attacker can intercept and modify this parameter to set an arbitrary balance amount, effectively creating accounts with unlimited funds.

### Vulnerability Type
- Business Logic Flaw
- Insufficient Server-Side Validation
- Client-Side Parameter Tampering

### Affected Endpoint
`POST /api/add_balance`

### Steps to Reproduce

1. Navigate to the "Open an Account" registration page

   ![Bug 1 - Image 1](https://blogger.googleusercontent.com/img/a/AVvXsEiJlylI_UQP7yKqHMmv8eLig9cMha6t-Zuj94qo7rL6wnScr_u-8jcWwp9AgG-38fXuKmb6DzaG3d5v1iN7RvvdkF4W5Ko2FL3N38Ht6hYntecc1EEeYDU7UtVaLcoe134ZBYTYh4v7klXFJwhQGgejJXmzCiELwqUS0d6YVv8kOOZggGu21zBsgJI4nIU)
   *Account registration page showing ৳1,000 welcome bonus offer*

2. Fill in all required account details:
   - Full Name: Shakhawat Hossain 1
   - Email Address: 0xShakhawat+1@wearehackerone.com
   - User ID: 0xShakhawat1
   - Account Type: Savings Account
   - Branch: Banani, Dhaka
   - Password: (secure password)

   ![Bug 1 - Image 2](https://blogger.googleusercontent.com/img/a/AVvXsEh79X69A-uTCPNlU6jSN_QAlJw9g1U8u4JzPzTSIHghLOrJ9rPu2Oo0Zw_64BHEyr9n3BlauhXW1-alFJyzcDGKy9eDq_uD-LIpJysfiUQPZhm9z0cK54UHtl-QgVOxrgMf13nYQ03OA6ZPnoHmkNG2IFom4elnNXf35L-QMzyH_gupFwHoViQ7Np1BXWo)
   *First request showing account creation POST to /api/account_opening*

3. **Do not click the "Open My Account" button yet**
4. Open Burp Suite and enable request interception
5. Click the "Open My Account" submission button
6. In Burp Suite, forward the first request (`POST /api/account_opening`)
7. Intercept the second request to `/api/add_balance`
8. Observe the request contains:
   ```json
   {
     "AC": "100173535658",
     "BL": "1000"
   }
   ```

   ![Bug 1 - Image 3](https://blogger.googleusercontent.com/img/a/AVvXsEhEF2uyO2aqab9Aq8S5ekQKtAZCr88UaZpLKBqPQsvH2Jfi_VxW7AO_NfRuYL3ZfUFIdtR3NrTa535XhtRyr3eFWuP_0xcy3oTlpibc0Fk-93gh8OghKl8x-QUBZA3YHn3qs7UB83py6QmujGcpP8DFZ2SzxycoHSNlWQ5qg3FdB-O_N3uldFHkFRH8h-k)
   *Intercepted request showing BL parameter set to default 1000*

9. Modify the `BL` parameter to any desired amount (e.g., `10000000000`):
   ```json
   {
     "AC": "100173535658",
     "BL": "10000000000"
   }
   ```

   ![Bug 1 - Image 4](https://blogger.googleusercontent.com/img/a/AVvXsEg9FCM53JP53k01hQoAsi1lkOujOMRDRCL54GMq1tUq5jCQwqBUrTfMW4hgOgwOhU1BEAuNypLiwv0zx0r7ki2cB43qH07X-ONvP8KLHlow6Nc9reDFf428h67zFgWuypZpBTff3SN1IGaYzAJGsSN_BLpU9wb9CUkM3gH_TLmy7bW1PT4YGs6Amq5cSA8)
   *Modified request with BL parameter changed to 10000000000*

10. Forward the modified request
11. Observe the response showing success with the manipulated balance:
    ```json
    {
      "new_balance": 10000000000.0,
      "success": true
    }
    ```

    ![Bug 1 - Image 5](https://blogger.googleusercontent.com/img/a/AVvXsEjLWA0pohYgpagjJ6sBccpNppmkl1s9mOJ1wM5_8WLQTvNnUiZbGBjaiQfD0bl1qSPqrLL0F5rlS5wq5Wfgb9XOjImLFmz0v9HGOhLzbNqwaYUDksDGJCdXdDrelhcfoheOSxpnZVyq59PiEFLwzmBLz-Bl95yJ_AE6-Rs1WP56uZ-nTvRPZrmtMTfaDl8)
    *Server response confirming new_balance: 10000000000.0*

12. Log in to the newly created account and verify the inflated balance

    ![Bug 1 - Image 6](https://blogger.googleusercontent.com/img/a/AVvXsEg-WP3p1tEcxpRdwjciMm39RtGeUkPoR0Wc9e-PxPG7FpSG3z2-KAk1tAEdcWEiPdme1EFLfnAX9gBgnLDC2fFZQ064wllm6e9WCVluz6rY1aNZTsUwqPWO4Etmr9LfOxTXVNsCvzOQTxqraXiupaWxmXNy1Y3FLJ4R1b1tS3gXIxKdx7QVaTGS_R1jowk)
    *Dashboard showing inflated balance of ৳10,000,000,000.00*

### Impact
- **Financial Loss:** Attackers can create accounts with unlimited funds and potentially transfer/withdraw real money
- **Business Integrity:** Complete bypass of the promotional bonus system
- **Fraud:** Mass creation of accounts with arbitrary balances for fraudulent purposes
- **Regulatory Issues:** Potential violations of banking regulations and anti-money laundering requirements

### Recommendation
1. Implement server-side validation and control of account balances
2. Never trust client-side input for financial operations
3. Store promotional bonus amounts on the server and apply them during account creation
4. Implement transaction logging and anomaly detection for unusual balance changes

---

## Bug #5: IDOR Exposing Sensitive Customer PII and Payment Card Data

### Severity
**Critical** | **CVSS 9.4**

### Title
Unauthorized Access to Customer PII Including Card Numbers, CVV, and Email via Balance API IDOR

### Description
The balance inquiry API endpoint suffers from an IDOR vulnerability that exposes comprehensive customer personally identifiable information (PII) including full names, email addresses, complete credit/debit card numbers, CVV codes, and expiration dates. An attacker can enumerate account numbers and harvest sensitive data for thousands of customers.

### Vulnerability Type
- Insecure Direct Object Reference (IDOR)
- Information Disclosure
- Broken Access Control
- PCI-DSS Violation

### Affected Endpoint
`POST /api/balance`

### Steps to Reproduce

1. Log in to your ChaBank account
2. Navigate to the dashboard
3. Open Burp Suite and enable request interception
4. In the browser, refresh the dashboard page
5. In Burp Suite, locate the POST request to `/api/balance`

   ![Bug 9 - Image 1](https://blogger.googleusercontent.com/img/a/AVvXsEgVc0NmIaMhkCsjgCrptH0Z4fOebQiCehTaBRchKHRhCLPvLcX7MQFcQ-y6ORhndexTD9HmO7UI1Viz6Eql7xqen1eZuHUrfIyDRZGd-HGmh9qMZck0cu3gMHkTy7xHZcIqFd4zJSRmwFEvM_blSq_tGBv5_O737v3m3L7ThpDemcNklEdyqjd8qVvwRhg)
   *Burp Suite showing POST /api/balance request*

6. Right-click and select "Send to Repeater" (Ctrl+R)

   ![Bug 9 - Image 2](https://blogger.googleusercontent.com/img/a/AVvXsEiBQulsf627p2FkTa-02RK8wcaeqdRORuSq1jUcwIxUIYuShmRu9DcpAMsIfylsMu3H908JRjUJE-F3Phd0ISst3imft9JA7M90AFnUKwRi1lnYnTFVS-bdHiXRJfzriT-xfu10QDhc--p5xiF1zSJ6OQmHKvEJYOUqLgZbphFzkQ9MmUSPse6jISJh1vI)
   *Context menu showing "Send to Repeater" option*

7. In Repeater tab, observe the request body contains your account number:
   ```json
   {
     "account_number": "100141955843"
   }
   ```

8. Modify the account number to a victim's account number (e.g., "100100326247")
9. Click "Send" to execute the request
10. Observe the detailed response containing highly sensitive information:
    ```json
    {
      "account_number": "100100326247",
      "account_type": "Business",
      "balance": 1000.0,
      "branch": "Motijheel, Dhaka",
      "card_cvv": "606",
      "card_expiry": "11/29",
      "card_number": "4532672301947085",
      "email": "dummyaccount@dummy.com",
      "full_name": "Big Dummmyyyy Acccouuunnntttt",
      "profile_picture": "default.png",
      "success": true
    }
    ```

    ![Bug 9 - Image 3](https://blogger.googleusercontent.com/img/a/AVvXsEgBXloqDVQu5cqZP5Ln24-rwZ3eTY5-Ga4Nm0XuTJ2uQB-VKEWOocD9y18ywuOPU7cOkLFvvDtem5HvB5A4MFwfxGPyQ8HW_nOhZEj72IahA24TPEjCo5MZutmAXEBqD7VUhxncrha0KiaILT1P9CNkge7wYHXU3dvA4waegGZS2YE-5owIpWo-n-po-1Y)
    *Burp Repeater response showing victim's complete PII including full card number and CVV*

11. Repeat with different account numbers to harvest data from multiple victims

### Impact
- **PCI-DSS Violation:** Exposure of full card numbers and CVV codes violates payment card industry standards
- **Identity Theft:** Complete personal information available for identity fraud
- **Financial Fraud:** Card details can be used for unauthorized purchases
- **Mass Data Breach:** Attackers can enumerate and harvest thousands of customer records
- **Regulatory Penalties:** Massive fines from payment card networks and regulators
- **Criminal Liability:** Storing and transmitting CVV violates PCI-DSS requirements
- **Business Termination:** Loss of payment processing privileges
- **Class Action Lawsuits:** Exposure to significant legal liabilities

### Recommendation
1. Implement proper authorization checks to verify account ownership
2. **Never store or transmit CVV codes** - this is explicitly prohibited by PCI-DSS
3. Tokenize or mask card numbers (show only last 4 digits)
4. Implement session-based access control
5. Add rate limiting and anomaly detection
6. Encrypt sensitive data at rest and in transit
7. Implement comprehensive audit logging
8. Conduct immediate PCI-DSS compliance audit
9. Consider implementing data loss prevention (DLP) measures

---

## Bug #6: Local File Inclusion (LFI) via Path Traversal

### Severity
**Critical** | **CVSS 9.3**

### Title
Arbitrary File Read Through Path Traversal in Statement Download Endpoint

### Description
The statement download functionality is vulnerable to path traversal attacks, allowing attackers to read arbitrary files from the server's filesystem. By manipulating the `file` parameter in the download endpoint, attackers can access sensitive system files, application source code, configuration files, and database credentials.

### Vulnerability Type
- Local File Inclusion (LFI)
- Path Traversal
- Arbitrary File Read
- Information Disclosure

### Affected Endpoint
`GET /download?file=`

### Steps to Reproduce

1. Log in to your ChaBank account
2. Navigate to the dashboard

   ![Bug 10 - Image 1](https://blogger.googleusercontent.com/img/a/AVvXsEjaeLqtKi1JebWoGBRxW1s99kp1XRBBnEuOXcrodDFCb3Cv2fg9i8y4RZYo8cEs93XwY6L5JY1PgZZ6C_x1RIVWU77ddcDzA5M2zln_LbRH9fzMlY3lqHNAStpZgYHes__hp8sITuGc9EQvJfl9t8Ud4YCmHD1kwReQQQo9DV2o9mrNcLP9QfGzvfFRgTM)
   *Dashboard showing the "Statements" download button*

3. Open Burp Suite and enable request interception
4. Click the "Statements" download button
5. In Burp Suite, intercept the GET request to `/download?file=statement_[accountnumber]_[timestamp].pdf`

   ![Bug 10 - Image 2](https://blogger.googleusercontent.com/img/a/AVvXsEgEnTcjHt3ilfT5EHfPgaS7C_qtva308VMG5md1f3wxgir9NsI3mTqewRyikHgl75U2LveTALZYggvP5fD5zInQ-p-WKY_RSYiPEvw71NGi1DfYBftl8B4aU1JFmS1nYhjRAUfSUq_Px6eZcu-6YZVzAa-PLtXFRqfDOXuOXz9LToz6rBPNtt1Jc9LfMG4)
   *Intercepted normal download request in Burp Suite*

6. Right-click and select "Send to Repeater" (Ctrl+R)
7. In Repeater, modify the `file` parameter to include path traversal:
   ```
   GET /download?file=../../../etc/passwd HTTP/2
   ```

   ![Bug 10 - Image 3](https://blogger.googleusercontent.com/img/a/AVvXsEjjBzsI-Sflbq_C6JHQ72VWAeBnGD5zoMJYY_4iADoBQYEP1tHtljGKqDklzoH4lEhZVtxRMXuIO0rRcK9Fsk_ESABK9HB-CedCsz8Fb68Jb53GjLhO75zwwNBoM_eLbHV33JQ8k1mMECe5sh4H6adaUOwowJdtXOYLKIzoE0UHkFDWX9dQeUJ6yXm_3Vs)
   *Modified request with path traversal payload ../../../etc/passwd*

8. Click "Send" to execute the request
9. Observe the response contains the contents of `/etc/passwd` file showing system users
   *Response displaying /etc/passwd file contents with root and other system users*

10. Test other sensitive files:
    - `/download?file=../../../app/config.json` (application configuration)
    - `/download?file=../../../etc/shadow` (password hashes)
    - `/download?file=../../../var/log/apache2/access.log` (web logs)

### Impact
- **Source Code Disclosure:** Access to application source code reveals additional vulnerabilities
- **Credential Exposure:** Database credentials and API keys in configuration files
- **System Compromise:** Reading `/etc/shadow` could lead to system-level access
- **Database Access:** Exposed database credentials enable direct database attacks
- **Privilege Escalation:** Access to system files can facilitate lateral movement
- **Complete System Takeover:** Combined with other vulnerabilities, could lead to RCE
- **Data Breach:** Access to log files may expose customer data and session tokens

### Recommendation
1. Implement strict input validation and sanitization for file parameters
2. Use a whitelist approach for allowed files
3. Store files with random, non-guessable names
4. Implement proper access control checks before serving files
5. Use absolute paths and validate against allowed directories
6. Remove directory traversal sequences (../, ..\) from input
7. Run the web application with minimal file system privileges
8. Implement Web Application Firewall (WAF) rules
9. Store sensitive files outside the web root directory

---

## Bug #7: SMTP Credential Exposure via LFI (Chained with Bug #6)

### Severity
**Critical** | **CVSS 8.8**

### Title
Exposed SMTP Server Credentials Enabling Email Phishing and Account Takeover Campaigns

### Description
By exploiting the LFI vulnerability (Bug #6), attackers can access the application's configuration file (`/app/config.json`) which contains hardcoded SMTP server credentials. These credentials can be used to send legitimate-looking phishing emails from the official ChaBank domain, making phishing campaigns highly effective. When combined with the IDOR vulnerability (Bug #5) that exposes customer email addresses, attackers can orchestrate large-scale targeted phishing attacks.

### Vulnerability Type
- Information Disclosure
- Hardcoded Credentials
- Security Configuration Weakness
- Chained Vulnerability Exploit

### Affected Endpoint
`GET /download?file=../../../app/config.json`

### Steps to Reproduce

1. Follow the steps from Bug #6 to exploit the LFI vulnerability
2. In Burp Suite Repeater, access the application configuration file:
   ```
   GET /download?file=../../../app/config.json HTTP/2
   ```

3. Click "Send" to execute the request
4. Observe the response contains SMTP credentials in plaintext:
   ```json
   {
     "smtp": {
       "host": "smtp.mailersend.net",
       "port": 587,
       "use_tls": true,
       "username": "MS_eCbcuI@test-z0vklo687x7l7qrx.mlsender.net",
       "password": "mssp.DICm5PT.jpzkmgq3y5n4059v.lZzB2hG",
       "from_email": "MS_eCbcuI@test-z0vklo687x7l7qrx.mlsender.net",
       "from_name": "ChaBank Bangladesh"
     }
   }
   ```

   ![Bug 11](https://blogger.googleusercontent.com/img/a/AVvXsEhG9JqF8o9x_PV1uDNDTiZq1lDhR2eiaIYT6tFI6w2oNpqwJ27SK9X9hKGhVDiWdUS-lgpt69Q5iG9sMqW4VDwW54xSbCLzgrdw1gcD2WqHNanK4Z66hxyZqHvNxVnnOtl7sT26MR2Q-KUIREy31CaF9izOn0H4Nh6iZ611WPXZ5KPrwqZgC_atfQUP1Ag)
   *Burp Suite response showing exposed SMTP configuration with credentials*

5. Use these credentials with an SMTP client to send emails as "ChaBank Bangladesh"
6. Exploit Bug #5 (IDOR) to enumerate customer email addresses
7. Send targeted phishing emails appearing to be from the legitimate bank

### Impact
- **Mass Phishing Campaigns:** Attackers can send legitimate-looking emails from the official bank domain
- **Credential Harvesting:** Victims are more likely to trust emails from the real domain
- **Account Takeover:** Phishing can be used to steal login credentials
- **Reputation Damage:** Bank's email domain could be blacklisted for spam
- **Financial Loss:** Customers tricked into revealing credentials or transferring money
- **Regulatory Penalties:** Failure to protect customer communications
- **Social Engineering:** Highly effective attacks due to apparent legitimacy
- **Business Email Compromise (BEC):** Advanced targeted attacks on business accounts

### Recommendation
1. Never hardcode credentials in configuration files
2. Use environment variables or secure secret management systems (e.g., HashiCorp Vault, AWS Secrets Manager)
3. Implement proper file access controls (fix Bug #6 first)
4. Rotate SMTP credentials immediately
5. Implement email authentication (SPF, DKIM, DMARC records)
6. Add rate limiting on email sending
7. Implement anomaly detection for unusual email patterns
8. Use separate sending domains for transactional vs. marketing emails
9. Educate customers about phishing and official communication channels

---

## Bug #8: Stored Cross-Site Scripting (XSS) in Transfer Reference Field

### Severity
**High** | **CVSS 8.1**

### Title
Stored XSS via Money Transfer Reference Field Affecting Recipient Dashboard

### Description
The money transfer functionality fails to properly sanitize the "Reference" field, allowing attackers to inject malicious JavaScript payloads. When a victim views their dashboard after receiving a transfer with an XSS payload in the reference, the malicious script executes in their browser context, potentially compromising their session and sensitive information.

### Vulnerability Type
- Stored Cross-Site Scripting (XSS)
- Insufficient Input Sanitization
- Improper Output Encoding

### Affected Endpoint
`POST /api/transfer`

### Steps to Reproduce

1. Log in to an attacker account
2. Navigate to "Transfer Money" from the dashboard

   ![Bug 4 - Image 1](https://blogger.googleusercontent.com/img/a/AVvXsEgCx9ag-BcqsgctC0A9DW1bCyhcH-qnXdf9aUNUEO374xaWKZfo85EPZwFvbdfbY-XoyKzEBbf9ZI3P1_qpPrIIVtD9A1hZXonBEeQ4a2RLDECE1K36ObmG4NNpfwH8kqdzG-oijsT8kTBKzHH8FWCNPVqVANaij0ABmBcJRviJW2SHxCGWZPfK2egxFKY)
   *Transfer Money form with recipient account number field*

3. Enter a victim's account number in the "Recipient Account Number" field (e.g., 100133289368)
4. Enter any valid transfer amount (e.g., 1337)
5. In the "Reference (Optional)" field, inject an XSS payload:
   ```html
   <img src=x onerror=alert('XSS');>
   ```

   ![Bug 4 - Image 2](https://blogger.googleusercontent.com/img/a/AVvXsEj3j9TkyjmNEMJavVBbG1U67SaAhEm6L_AKPBbdSeL2ulCkwLaJBUahSu5hxyn9zF3a7GHg3jKmLH-aKPEbCUKNvcgaxp_JQYhMF4_QntsN4XDp9Yv3vSypJx9FD9WPiENWr122yYb-W3iQ_XlYTj1NgKokaqcyKEp1uiygtWpZz1gOOMoCLAVJR4Ci7Io)
   *XSS payload entered in the Reference field*

6. Click "Transfer Now" to complete the transfer
7. Log in to the victim's account (or wait for victim to check their dashboard)
8. View the dashboard
9. Observe that the XSS payload executes, displaying an alert box

   ![Bug 4 - Image 3](https://blogger.googleusercontent.com/img/a/AVvXsEg0-YnqUzmtiPOqRPj_7xjn0fCFh3SUumhF3rJvpSPWBZenzLJlALZxTJKae9w7Pc1p_temzeE72d5gPngKRwjoZID1WpwoG2JtqWpO-nh9oiUOOsfEAxt8XE9Br0xf28TVr5kHEGG5ODJUa62-reVJZ8UNMBP37rsQcn4EJWDpFkf5gDyvQQdNYtUFEFE)
   *Victim's dashboard showing XSS alert execution with "XSS" message*

10. Check the transaction history to see the unsanitized payload stored in the reference field

### Impact
- **Session Hijacking:** Attacker can steal session cookies and impersonate the victim
- **Account Takeover:** Malicious scripts can perform actions on behalf of the victim
- **Credential Theft:** Fake login forms can be injected to phish credentials
- **Financial Fraud:** Automated transfers can be initiated from the victim's account
- **Data Exfiltration:** Sensitive account information visible on the dashboard can be stolen
- **Widespread Attack:** One malicious transfer can affect the recipient's session repeatedly

### Recommendation
1. Implement proper input validation and sanitization for all user-supplied fields
2. Use context-aware output encoding (HTML entity encoding for HTML context)
3. Implement Content Security Policy (CSP) headers to mitigate XSS execution
4. Sanitize data on both input (server-side) and output (client-side) layers
5. Use a whitelist approach for allowed characters in reference fields
6. Consider implementing a maximum length limit for reference fields
7. Add automated security scanning for XSS vulnerabilities

---

## Bug #9: Stored Cross-Site Scripting (XSS) in Bill Payment Biller Name

### Severity
**High** | **CVSS 8.1**

### Title
Stored XSS via Bill Payment Biller Name Parameter Affecting Payee Dashboard

### Description
Similar to Bug #8, the bill payment functionality contains a stored XSS vulnerability. The "biller_name" parameter is not properly sanitized on the server-side, and while the frontend displays a dropdown menu, attackers can intercept the request and inject malicious JavaScript payloads directly into this parameter. The payload executes when the recipient (payee) views their dashboard.

### Vulnerability Type
- Stored Cross-Site Scripting (XSS)
- Insufficient Input Sanitization
- Client-Side Security Control Bypass

### Affected Endpoint
`POST /api/pay_bill`

### Steps to Reproduce

1. Log in to an attacker account
2. Navigate to "Pay Bills" from the dashboard

   ![Bug 5 - Image 1](https://blogger.googleusercontent.com/img/a/AVvXsEjJBZBimhrQNk0dvVqcv8RCFAJBv5xJXR1rlLWfY-acFpF_j9pxI2GVFuuHq0sB7ombxCKJHkPWsJD7Wk6J1h3DyWl1akL9EvxAHiJF-MSJ03hp86Hr7rUfftgd7am6JzyriGCdKXMqJXOrRxtsdN2X0ByH818wSqAgqxc_HjPbMcyibnhS9kfWRZDGwig)
   *Pay Bills page with category selection (Electricity, Gas, Water, Internet, Mobile, TV/DTH)*

3. Select any bill category (e.g., Electricity)
4. Fill in the bill payment form:
   - Biller Name: DESCO (from dropdown)
   - Consumer/Account Number: 100141955843 (victim's account)
   - Amount: 13

5. **Do not click "Pay Bill" yet**
6. Open Burp Suite and enable request interception
7. Click "Pay Bill"
8. In Burp Suite, intercept the POST request to `/api/pay_bill`

   ![Bug 5 - Image 2](https://blogger.googleusercontent.com/img/a/AVvXsEhlEtQfdpT7FcQTMot5uUHnYXraJNZPtMBBOmiqM8tTHpMeMT53-6euiYFQmi6AcM9ZDPauUvZmz9VZZLgZYIYESBMGjrm1FkV19cKIfPGMX2Y4ShkfW297K5fMuIAFu0iOV1i5hcD7ugvI6uDEbXl3TMVYVBSrAckACLadYca9PexPg312xsHx8kJHL30)
   *Intercepted request showing original biller_name in Burp Suite*

9. Modify the `biller_name` parameter value to an XSS payload:
   ```json
   {
     "biller_category": "electricity",
     "biller_name": "<img src=x onerror=alert('hereIsXSS');>",
     "bill_account": "100141955843",
     "amount": 13
   }
   ```

   ![Bug 5 - Image 3](https://blogger.googleusercontent.com/img/a/AVvXsEgb-94V9MjoYn7vK-bxQdosKDmiEWyDi4RxZiP09ZmhApAOMHqQZ6kg4LLHZjrpB_R5OESWml_upUIi6M9eII0OfWX1krWq1Dt9AUEnNmzs6L8SMF64r4gLIqK9zpN5VFUkey6M4CRbXTxzaNn5Bj7KbIcnkKffq9BP-w5fv3lmsVVz9a-3MjKeK-Dn4_Q)
   *Modified request with XSS payload in biller_name parameter*

10. Forward the modified request
11. Observe "Bill paid successfully!" confirmation

    ![Bug 5 - Image 4](https://blogger.googleusercontent.com/img/a/AVvXsEitqP4GRU7HNkSS7ZDlsWbEPO1QLTmXHcvx-M-0ewvOB6Nv0C2XevIKAqmx4s-J3lZA69e_1s0RWqBbousjFDBlDyVOxmZrx0ikpPoyixoBnCgQuqykU3K30LW2wFASUPQ7_6RmeUMOdFzc5gveMwAMDH929iIAxVnvRTT7_RMoIHmrwQuGPx7MJ5V_auQ)
    *Success message after bill payment*

12. Log in to the payee/victim account
13. View the dashboard and observe the XSS payload executing with "LEET_XSS" alert

### Impact
- **Session Hijacking:** Theft of authentication tokens and session cookies
- **Account Takeover:** Full control over victim's account through malicious scripts
- **Credential Harvesting:** Injection of fake login prompts
- **Financial Fraud:** Unauthorized bill payments or transfers
- **Data Breach:** Exfiltration of sensitive financial information
- **Persistent Attack:** XSS payload persists in transaction history

### Recommendation
1. Implement server-side input validation and sanitization for all parameters
2. Never trust client-side validation; always validate on the server
3. Use parameterized queries and ORM frameworks to prevent injection attacks
4. Apply context-appropriate output encoding (HTML escaping)
5. Implement Content Security Policy (CSP) headers
6. Use allowlists for acceptable biller names
7. Add rate limiting to prevent automated exploitation

---

## Bug #10: Stored Cross-Site Scripting (XSS) in International Wire Transfer Country Field

### Severity
**High** | **CVSS 8.1**

### Title
Stored XSS via International Wire Transfer Country Parameter Affecting Recipient Dashboard

### Description
The international wire transfer feature contains a third stored XSS vulnerability in the "country" parameter. Despite the frontend using a dropdown menu, attackers can bypass this control by intercepting the request and injecting malicious JavaScript. The payload executes when the recipient views their transaction history or dashboard.

### Vulnerability Type
- Stored Cross-Site Scripting (XSS)
- Insufficient Server-Side Validation
- Client-Side Control Bypass

### Affected Endpoint
`POST /api/international_transfer`

### Steps to Reproduce

1. Log in to an attacker account
2. Navigate to "International Wire Transfer" tab

   ![Bug 6 - Image 1](https://blogger.googleusercontent.com/img/a/AVvXsEh7h3KMRj3QJJmxo9P5UC_hawAevrpGDwESe_3ZuYyXegBatFpt59a7Qq9TAI5mgbLPX-Vic33TW7L3HcevMHwsk3Worjr8_sMI3CAoUuEKO6AMcZw5LR9h1-rMnCk2XAtS-zF3qGphBUjJEovc4u7IF3SaHHL7NiqSgtuURgH3nuZeIgvK7MTfGQZSBio)
   *International Wire Transfer form with all required fields*

3. Fill in all required fields:
   - Recipient Name: Holllaaa
   - Recipient Account: 100125878576 (victim's account)
   - Recipient Bank: ChaBank
   - SWIFT/BIC Code: CHABDDHK
   - Country: United States (select from dropdown)
   - Currency: USD - US Dollar
   - Amount (BDT): 10

4. **Do not click "Send Wire Transfer" yet**
5. Open Burp Suite and enable request interception
6. Click "Send Wire Transfer"
7. In Burp Suite, intercept the POST request to `/api/international_transfer`

   ![Bug 6 - Image 2](https://blogger.googleusercontent.com/img/a/AVvXsEgoRbBcLhv6JHUMcfo32JchC1f9leR6zDEFd9aSCcoBUbfBH_7LdfaOZhQBfQXOPzdMCSzNUOFW9BS5Yj3nPXHV5k7YtnEEXzbMvxFKGcs8fw9SZcg3EH5U8V4UUdu7ebwSVI3LBAWmiSgcwyqByp-oXzXZIJMNs9VOT0VraL17fZk_gEn95Aq18bnvmK8)
   *Intercepted request showing country parameter in Burp Suite*

8. Modify the `country` parameter to inject an XSS payload:
   ```json
   {
     "recipient_name": "Holllaaa",
     "recipient_account": "100125878576",
     "recipient_bank": "ChaBank",
     "swift_code": "CHABDDHK",
     "country": "<img src=x onerror=alert('International_Wire_Xss');>",
     "amount": "10",
     "currency": "USD"
   }
   ```

9. Forward the modified request
10. Observe successful transfer confirmation
11. Log in to the victim/recipient account
12. View the dashboard and observe the XSS payload executing

    ![Bug 6 - Image 3](https://blogger.googleusercontent.com/img/a/AVvXsEiSnbUC62gh9Sr0ciLaCpLKVXbtr2hKf5XW7xdYh2_3m1-qz-LvztXg9idTLHaQPbPmGESEGQJgNCaeE1R5oTZRLa4RtC4L3iAqPnK3fGIikoRWE-a2QGyxo4J7emjHThIP_hCb11xyRlYKbNbEPXw1mNc4f4tK9T-uJkN70tU0sWbevDWfkUq90ZquWd0)
    *Victim's dashboard showing XSS execution with "International_Wire_Xss" alert*

### Impact
- **Session Hijacking:** Theft of authentication cookies and tokens
- **Account Takeover:** Complete control over victim's banking session
- **Financial Fraud:** Unauthorized international wire transfers
- **Data Exfiltration:** Stealing sensitive financial and personal information
- **Reputation Damage:** Loss of customer trust in international banking services
- **Cross-Border Implications:** Potential international regulatory violations

### Recommendation
1. Implement server-side input validation for all international transfer parameters
2. Apply HTML entity encoding before displaying user-supplied data
3. Never rely solely on client-side dropdown menus for security
4. Implement Content Security Policy (CSP) headers
5. Use prepared statements and parameterized queries
6. Add XSS protection filters and Web Application Firewall (WAF)
7. Conduct regular security audits and penetration testing

---

## Bug #11: Negative Balance via Overdraft on Debit Card Account

### Severity
**High** | **CVSS 7.5**

### Title
Unauthorized Overdraft Functionality Allowing Negative Balances on Non-Business Debit Card Accounts

### Description
Despite advertising a "Free virtual debit card" for regular accounts, the ChaBank platform allows users to overdraft their accounts by transferring amounts exceeding their available balance. This results in negative account balances, which should not be permitted for standard debit card accounts (overdraft is typically reserved for credit cards or business accounts with pre-approved credit lines).

### Vulnerability Type
- Business Logic Flaw
- Insufficient Balance Validation
- Improper Access Control

### Affected Endpoint
`POST /api/transfer`

### Steps to Reproduce

1. Create a new account on ChaBank LTD (starts with ৳1,000 welcome bonus)

   ![Bug 2 - Image 1](https://blogger.googleusercontent.com/img/a/AVvXsEj0QabWxyASjWsHJa9yMgUAKZgy8FXbh5g-c2vFBmXYItkWO1U12-w_x85DcfNhDYxVhm2I_b4hfsR92JBjBHVkpAUye19w4SzmhbRAsZjcgMqar5SEdEjqSB2YhpDAqKE0Was_jfvPwIn6Ah4vgDzP2-pLJsuf6PlKwsU5Z6vILkWOd3-jhBnOMQVF_9k)
   *Registration page highlighting "Free virtual debit card" feature*

2. Log in to the dashboard and verify the current balance (e.g., ৳2,000)

   ![Bug 2 - Image 2](https://blogger.googleusercontent.com/img/a/AVvXsEj_GShvWkHE-O5ut-iAVjJ-SkACtyxuEUCkyX643PieHVy4ypYoodYlJ7c0-abRw6Nez-JKxiOxlcI6_UGe5jA7m4P0Xqke8Hi0Jp4FiO_OnbjqpLG_kAE0pM8bTcKPp5jF6NbWLN3Mk8Bea-PUKknpgyBOQ2CfprK3eO1UtzS77b24BFAtT4U0Cc7TXvg)
   *Dashboard showing initial balance of ৳2,000*

3. Navigate to "Transfer Money"
4. Select or manually enter a recipient account number (e.g., 100144712002)
5. Enter a transfer amount **greater than the current balance** (e.g., ৳3,000 when balance is ৳2,000)
6. Add an optional reference note (e.g., "business logic")
7. Review the transfer summary showing Total: ৳3,000
8. Click "Transfer Now"

   ![Bug 2 - Image 3](https://blogger.googleusercontent.com/img/a/AVvXsEj4eBjNYM69UrP7DCtNjvUSG31YaB1tIhyblLQE_9XCQ-cAPI3TVvfnD0u7F2IrVrT5ZJr7QP2mC0btsyleYla2Th0JUP0y99iEgFqLruWuFB02QaR6thacSq3w8jgBVRfryq6z6UhpEmd65sPZdSBkl1jI5ukW3Lu721btaes3OHWSr984fcsanG0zE3M)
   *Transfer form with ৳3,000 amount exceeding available ৳2,000 balance*

9. Observe that the transaction succeeds
10. Return to the dashboard and verify the account now shows a **negative balance** (৳-1,000)

    ![Bug 2 - Image 4](https://blogger.googleusercontent.com/img/a/AVvXsEjvEdXZiDkPmMe7YW0mO3flejf03r4M_4VrKFyFSwhbAMn4kJOxZD9VxDQtA3BzXROnPoJ-y2_kncVl-GI8TzKjDWTrw5iJE5hdY6m_dHAsRcc-F7ZmxvpWi8M1d72q3VHZRxa-5ufFWUgd5hR3nOUklXCfTZ8LriTqWIEbwakJFa12X4Ma6qAcbjkeKhU)
    *Dashboard after transfer showing negative balance ৳-1,000*

### Impact
- **Financial Loss:** Users can spend more money than they have, creating debt for the bank
- **Credit Risk:** Unauthorized extension of credit without proper approval processes
- **Account Type Confusion:** Debit cards should not allow overdrafts; this violates the advertised account features
- **Fraud Potential:** Malicious users could exploit this to overdraft and abandon accounts
- **Regulatory Compliance:** Violation of banking regulations regarding credit extension and overdraft policies

### Recommendation
1. Implement strict server-side balance validation before processing transfers
2. Reject any transaction where the amount exceeds the available balance
3. If overdraft functionality is desired, implement it only for approved business accounts with proper credit checks
4. Add real-time balance checks during the transaction processing workflow
5. Implement transaction rollback mechanisms for failed balance validations

---

## Bug #12: Insecure Direct Object Reference (IDOR) in Statement Generation

### Severity
**High** | **CVSS 7.5**

### Title
Unauthorized Access to Customer Bank Statements via IDOR Vulnerability

### Description
The statement download functionality uses predictable account numbers without proper authorization checks. An attacker can intercept the statement download request and modify the `account_number` parameter to access and download bank statements belonging to other customers, exposing sensitive financial information including transaction history, balances, and personal details.

### Vulnerability Type
- Insecure Direct Object Reference (IDOR)
- Broken Access Control
- Insufficient Authorization

### Affected Endpoint
`POST /api/generate_statement`

### Steps to Reproduce

1. Log in to your ChaBank account
2. From the dashboard, locate the "Statements" button

   ![Bug 7 - Image 1](https://blogger.googleusercontent.com/img/a/AVvXsEgQluXV-k2Yb-dS7oV6-ec9_EeZOGwul6pKk7Cberc_iYOQYuD0-CYt6fUHnQ9FbDqdf9p77ur5Y3vzwD0_CNwYEsnBxFc5dU9KhotSiGibu55Xj1hlRMJIvdomvGTdkFl2oVUZ-B0lb0DMaSz1-7DeFem2wV1La39ll0Q9HUHbmkpTvG4J82mLpi4jeq4)
   *Dashboard with Statements download button in Quick Actions*

3. Open Burp Suite and enable request interception
4. Click the "Statements" button to download your account statement
5. In Burp Suite, intercept the POST request to `/api/generate_statement`

   ![Bug 7 - Image 2](https://blogger.googleusercontent.com/img/a/AVvXsEjHAqS8h4skYATwadlHSQqntl84aUDt-RDj-ytnpZSNmLXgZIKN5zrsU4D3g9oFtYB8Opu5nJqrzw7dzj1esmC2Mxsb3J_-HCh8FCSOpqe2iulc3_9KZ_D5hY3_IKTk3P2hfdPDdPpFhxee7Q9fCtARXFy7lAtZfWwMiNq7KYxMMDYB-lOYasOLNJPgXUo)
   *Intercepted request showing account_number parameter*

6. Observe the `account_number` parameter containing your account number (e.g., "100187718002")
7. Send this request to Repeater (Ctrl+R)
8. In Repeater, modify the `account_number` parameter to a victim's account number:
   ```json
   {
     "account_number": "100173535658"
   }
   ```

   ![Bug 7 - Image 3](https://blogger.googleusercontent.com/img/a/AVvXsEg1GnFZ_33GeVS_T3w82IPDaoEswh1VYtEtJ4dlGcpDwsOqgVzEGpSqerZI6ARy65voGYLGmfFzn18DDVe7M-6d_L7rE882G_pP-uPIUrGy2wY-w6j6yRFiRSokuAjr71imnyTmkXb9NuYeySwXitoq33FkRNVwfpBFq55tQNeRYo-CG4VJQpzh4go4neo)
   *Modified request with victim's account number in Burp Repeater*

9. Click "Send" to execute the request
10. Observe that the response contains a success message with a filename:
    ```json
    {
      "filename": "statement_100173535658_20251121130128.pdf",
      "success": true
    }
    ```

11. The system generates and allows download of the victim's bank statement
12. Download the PDF and verify it contains the victim's:
    - Full name and account details
    - Complete transaction history with dates, amounts, and references
    - Current balance
    - Branch information

    ![Bug 7 - Image 4](https://blogger.googleusercontent.com/img/a/AVvXsEg_j1I8O-egnQKOd7MdkQ7-pHlqSygpzN5y_qWfMXQ94PV7ZbvwDL8PA3ibu2fqszBh-8LPjWQiHxtb22lXwrqbdmgz9_1Wd3_UOFqoAO7rb9qkz9mm_uoSUSHzKztP6hLYTLBmQiIejzc3ZUHxAnNw2ev-XbGLTjSo2RMxaRY0uiogKbZweWbHCoH7UPc)
    *Downloaded victim statement PDF showing sensitive financial information and transaction history*

### Impact
- **Privacy Violation:** Unauthorized access to customers' financial records
- **Data Breach:** Exposure of transaction history, balances, and account details
- **Identity Theft:** Statements contain full names, account numbers, branch information
- **Regulatory Violation:** Breach of banking secrecy laws and data protection regulations (GDPR, PCI-DSS)
- **Reputational Damage:** Loss of customer trust and potential lawsuits
- **Competitive Intelligence:** Business account statements could reveal trade secrets

### Recommendation
1. Implement proper authorization checks to verify the requesting user owns the account
2. Use session-based authentication to validate account ownership
3. Implement role-based access control (RBAC)
4. Use non-sequential, non-guessable identifiers (UUIDs) for resources
5. Log all statement access attempts for audit trails
6. Implement rate limiting to prevent mass data harvesting
7. Add multi-factor authentication for sensitive operations

---

## Summary of Vulnerabilities

| Bug # | Title | Severity | CVSS | Type |
|-------|-------|----------|------|------|
| 1 | SSTI Leading to RCE | Critical | 10.0 | Remote Code Execution / SSTI |
| 2 | Account Takeover via OTP Leakage | Critical | 10.0 | Broken Authentication |
| 3 | Self-Transfer Balance Multiplication | Critical | 9.9 | Business Logic / Transaction Flaw |
| 4 | Balance Manipulation During Account Creation | Critical | 9.8 | Business Logic / Parameter Tampering |
| 5 | IDOR Exposing PII and Card Data | Critical | 9.4 | Broken Access Control / IDOR / PCI-DSS Violation |
| 6 | Local File Inclusion via Path Traversal | Critical | 9.3 | Path Traversal / LFI |
| 7 | SMTP Credential Exposure | Critical | 8.8 | Information Disclosure / Hardcoded Credentials |
| 8 | Stored XSS in Transfer Reference | High | 8.1 | Cross-Site Scripting (XSS) |
| 9 | Stored XSS in Bill Payment Biller Name | High | 8.1 | Cross-Site Scripting (XSS) |
| 10 | Stored XSS in International Wire Country Field | High | 8.1 | Cross-Site Scripting (XSS) |
| 11 | Negative Balance via Overdraft | High | 7.5 | Business Logic / Insufficient Validation |
| 12 | IDOR in Statement Generation | High | 7.5 | Broken Access Control / IDOR |

## Overall Risk Assessment

**CRITICAL RISK LEVEL**

ChaBank LTD's web application contains multiple critical and high-severity vulnerabilities that pose an existential threat to the organization. The combination of:

- **Remote Code Execution capabilities** (Bug #1)
- **Complete account takeover vulnerabilities** (Bug #2)
- **Unlimited balance generation** (Bugs #3, #4)
- **Massive PCI-DSS violations** (Bug #5)
- **System file access** (Bug #6)
- **SMTP credential exposure** (Bug #7)
- **Multiple XSS vulnerabilities** (Bugs #8, #9, #10)
- **Broken access controls** (Bugs #5, #12)

...makes this application completely unsuitable for production use in its current state.

### Immediate Actions Required

1. **Take the application offline immediately**
2. Conduct a comprehensive security audit
3. Implement all recommended fixes before any redeployment
4. Notify affected customers if any exploitation has occurred
5. Engage with PCI-DSS auditors and banking regulators
6. Consider engaging professional security consultants
7. Implement a secure SDLC process going forward

---

**Report Generated By:** Md. Shakhawat Hossain (0xShakhawat)
**Email:** 0xshakhawat@wearehackerone.com
**Date:** 22 November 2025
**Event:** HackerOne Bug Hunt 2026 Qualifiers