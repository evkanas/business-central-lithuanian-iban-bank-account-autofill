# Business Central Lithuanian IBAN Bank Account Autofill

EVK Solution is a sample Microsoft Dynamics 365 Business Central extension that autofills customer and vendor bank account cards from a Lithuanian IBAN and a user-maintained bank directory.

The extension is designed as a clean public portfolio project for Business Central consultants and AL developers. It contains no production customer, vendor, bank account, or personal data.

For instructions aimed at users, consultants, and administrators, see the [User Guide](docs/USER_GUIDE.md).

## Business problem

Users often re-enter the same bank name, address, SWIFT code, and contact details on bank account cards. This extension keeps those details in one configurable directory and applies them consistently when an IBAN identifies a known Lithuanian bank.

## How it works

When the `IBAN` field is validated on a **Customer Bank Account** or **Vendor Bank Account** card, its page extension calls the shared `EVK Bank Account Autofill` codeunit and refreshes the current page.

For an IBAN beginning with `LT`, the codeunit reads positions 5–9 as the five-digit Lithuanian bank code. It then:

1. Copies the IBAN into **Bank Account No.** (limited safely to the target field length).
2. Generates **Code** from the bank code only when Code is empty. If that code already exists for the customer or vendor, `IncStr` is used to find the next available code.
3. Sets **Bank Branch No.** from the extracted bank code.
4. Looks up that branch code in **EVK Bank Directory**.
5. If found, fills the name, address, city, post code, SWIFT code, phone, email, home page, and contact fields.

If the bank code is not found, no error is raised. Only values safely derived from the IBAN are filled. An existing bank account Code is never overwritten.

The page triggers contain no business rules; they only delegate to the autofill codeunit and refresh the visible record. No `CurrPage.SaveRecord()` call is used.

## Bank directory setup

In Business Central, search for **EVK Bank Directory**. Create one record for each bank code that should be recognized. The directory supports:

- Code
- Bank Branch No.
- SWIFT Code
- Name and address
- City and post code
- Phone number and email
- Home page
- Contact name

**Bank Branch No.** must be unique and should match the five digits held in positions 5–9 of the Lithuanian IBAN.

## Neutral sample

The following values are deliberately fictional and are intended only to demonstrate the field positions:

| Field | Sample value |
|---|---|
| Directory Code | `SAMPLE` |
| Bank Branch No. | `00000` |
| Name | `Example Bank` |
| SWIFT Code | `EXAMPLE0XXX` |
| Email | `bank@example.invalid` |
| IBAN-shaped test value | `LT00 00000 00000000000` |

Remove spaces before entering the test value if the Business Central field does not normalize them. `LT00 00000 00000000000` is an intentionally fake, IBAN-shaped value; it is not presented as a valid or usable bank account.

## Install in a sandbox

1. Open this folder in Visual Studio Code with the AL Language extension installed.
2. Adjust `.vscode/launch.json` for your Business Central sandbox if required.
3. Run **AL: Download Symbols**.
4. Compile with **AL: Package**.
5. Publish with **AL: Publish** (`F5`), or upload the generated `.app` from **Extension Management** in the sandbox.
6. Assign the **EVK Bank Autofill** permission set to test users if it is not granted through another permission set.

The manifest currently targets Business Central application/platform 28.0 and runtime 17.0. Adjust these versions if the destination sandbox requires a different baseline.

## Manual test checklist

1. Publish and install the extension in a Business Central sandbox.
2. Open **EVK Bank Directory**.
3. Add the fictional directory record shown above, using branch code `00000`.
4. Open a Customer Bank Account card and start a new record.
5. Enter `LT000000000000000000` in IBAN and leave Code empty.
6. Confirm Code is generated from `00000`, Bank Account No. and Bank Branch No. are filled, and the sample directory details are applied.
7. Repeat the test on a Vendor Bank Account card.
8. Enter an LT-prefixed, IBAN-shaped value with a five-digit bank code absent from the directory. Confirm no error is raised and only derived fields are filled.
9. Enter a value while Code is already populated. Confirm the existing Code is not overwritten.
10. Enter a non-Lithuanian value. Confirm no bank-directory lookup occurs.

## Scope and limitations

This extension performs focused autofill, not banking compliance validation. It checks only what is necessary to extract a numeric, five-digit bank code from an `LT`-prefixed value. It does **not** implement ISO 13616 checksum validation, prove that an IBAN is genuine, or verify that banking details are current. Add a dedicated validation service or checksum implementation if those guarantees are required.

## Project structure

```text
app.json
AppSourceCop.json
README.md
src/
  codeunit/
  page/
  permissionset/
  table/
```

## Author

Created by Evaldas Jablonskas

Business Central / AL portfolio: [evaldasjablonskas.lt](https://evaldasjablonskas.lt/)

## Data and licensing note

The repository contains no production customer data, vendor data, real bank account numbers, real IBANs, personal names, phone numbers, or confidential company information. All documented examples use reserved or visibly fictional values. Review licensing and add a `LICENSE` file appropriate for your intended public repository before publishing.
