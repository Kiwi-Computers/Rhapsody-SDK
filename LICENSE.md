# Kiwi Software License Agreement

**Version 1.0**  
**Effective Date: November 1, 2026**  

**THE SOFTWARE IS LICENSED, NOT SOLD.**

**IMPORTANT NOTICE: PLEASE READ THIS SOFTWARE LICENSE AGREEMENT ("LICENSE") CAREFULLY BEFORE DOWNLOADING, INSTALLING, OR USING THE SOFTWARE. BY DOWNLOADING, INSTALLING, COPYING, ACCESSING, OR OTHERWISE USING THESE FILES (INCLUDING BUT NOT LIMITED TO RELEASE IMAGES, BETAS, DEVELOPER PREVIEWS, SOURCE FILES, OR THE SOFTWARE DEVELOPMENT KIT), YOU AUTOMATICALLY, UNCONDITIONALLY, AND COMPLETELY AGREE TO BE BOUND BY ALL THE TERMS AND CONDITIONS OF THIS LICENSE AGREEMENT. IF YOU DO NOT AGREE TO THE TERMS OF THIS LICENSE, DO NOT ACQUIRE, RETAIN, OR USE THIS SOFTWARE.**

### 1. Definitions

Whenever capitalized in this Agreement, the following terms shall have the designated meanings:

* **"Kiwi Computer"** means the entity or organization publishing and licensing the Software under this Agreement, together with its affiliates, successors, and assigns.
* **"Kiwi Hardware"** refers exclusively to genuine, Kiwi Computer-branded physical hardware products and devices.
* **"Software"** refers to the Rhapsody Software Development Kit, deliciOS Rhapsody operating system images, and all accompanying binaries, deployment utilities, and files.
* **"User-Space CPU Virtualization"** refers to the translation of application instructions for a host architecture (e.g., QEMU user-mode mapping, WSL) without booting an operating system kernel or simulating complete hardware.
* **"Full-System Virtualization"** refers to the use of hypervisors (e.g., VMware, VirtualBox, QEMU system-mode) to simulate a complete hardware environment and boot a full operating system kernel.

### 2. Authorized Hardware Requirement

Except as expressly permitted in Section 3, you are strictly prohibited from installing, booting, deploying, or running the full deliciOS Rhapsody operating system—in any form or variation, whether a production release image, beta release, developer preview, or prototype—on any computer, hardware device, virtual machine, emulator, cloud-hosted environment, or other computing platform that is not genuine Kiwi Hardware. Attempting to boot, virtualize (including via Full-System Virtualization), flash, or adapt the deliciOS Rhapsody operating system images for non-Kiwi hardware platforms constitutes a material violation of this Agreement.

### 3. Permitted Cross-Platform SDK Usage

Notwithstanding the hardware restrictions set forth in Section 2, Kiwi Computer grants you a limited, restricted right to install and execute the Rhapsody Software Development Kit (SDK) on non-Kiwi computer systems (such as macOS, Windows, or standard Linux distributions).

You acknowledge that the SDK utilizes underlying system archives (including `.tar.gz` and `.img.xz` files) and binaries of deliciOS Rhapsody. You are permitted to execute these embedded system components on non-Kiwi hardware solely and exclusively via deployment utilities and execution mechanisms provided, approved, or distributed by Kiwi Computer leveraging Docker containerization, Windows Subsystem for Linux (WSL), and User-Space CPU Virtualization.

You may not intercept, extract, flash, or utilize the bundled or decompressed SDK system archives to boot a general-purpose desktop, graphical instance, or standalone environment of deliciOS Rhapsody on non-Kiwi hardware. The OS payload is licensed strictly as a headless toolchain dependency for the express purpose of compiling and developing applications targeting genuine Kiwi Hardware.

### 4. Grant of License & Limited Internal Use

Subject to your strict adherence to the provisions of this Agreement, Kiwi Computer grants you a limited, non-exclusive, personal, revocable, and non-transferable license to execute and utilize the Rhapsody SDK strictly for your own internal purposes to test, evaluate, and develop applications intended to run on, or that support, Kiwi operating systems. No other license or implied rights are granted, whether by implication, estoppel, or otherwise. Nothing in this Agreement shall be interpreted as granting ownership of the Software to the user.

### 5. Restrictions on Redistribution

You shall not rent, lease, lend, sell, sublicense, distribute, assign, transfer, host, or otherwise commercially exploit the Rhapsody SDK, the deliciOS Rhapsody operating system, or any related software components. You may not distribute, make available over a network, or publish the SDK software or OS archives to any third parties without explicit, prior written authorization from Kiwi Computer.

### 6. Restrictions on Reverse Engineering, Modification, and AI Training

You are entirely and strictly prohibited from decompiling, reverse engineering, disassembling, attempting to derive the source code of, decrypting, modifying, or creating derivative works of the Rhapsody SDK or any core deliciOS Rhapsody operating system binaries and framework architectures. Furthermore, you are expressly prohibited from utilizing the Software, including its proprietary SDK components, framework metadata, headers, binaries, and other Kiwi Computer intellectual property, to train artificial intelligence models, machine learning algorithms, or to construct derivative cross-compilers or alternative toolchains, except as and only to the extent any foregoing restriction is prohibited by applicable law or to the extent as may be permitted by the licensing terms governing use of open-sourced components included with the Software. 

**Developer Ownership:** Ownership of software, source code, assets, and other content originally authored by you remains with you, except to the extent such content incorporates Kiwi Computer proprietary intellectual property.

### 7. Trademarks

Nothing in this Agreement grants any right to use Kiwi Computer's trademarks, trade names, logos, service marks, product names, or branding except as expressly authorized in writing by Kiwi Computer.

### 8. Termination & Rights Reserved

This License is effective until terminated. Your rights under this License will terminate automatically and instantly without notice from Kiwi Computer if you fail to comply with any term or condition of this Agreement. Upon the termination of this License, you must cease all use of the Software and destroy all copies, backups, extracted archives, and derivative installations of the Rhapsody SDK and OS files in your possession or control. Kiwi Computer reserves all intellectual property rights, titles, and interests not expressly granted under this platform framework.

### 9. Future Compatibility

Kiwi Computer reserves the right to modify the Software, SDK interfaces, system frameworks, APIs, package formats, and compatibility requirements at any time without prior notice or obligation to maintain backward compatibility.

### 10. Disclaimer of Warranties

YOU EXPRESSLY ACKNOWLEDGE AND AGREE THAT, TO THE EXTENT PERMITTED BY APPLICABLE LAW, USE OF THE SOFTWARE IS AT YOUR SOLE RISK AND THAT THE ENTIRE RISK AS TO SATISFACTORY QUALITY, PERFORMANCE, ACCURACY, AND EFFORT IS WITH YOU. THE SOFTWARE IS PROVIDED "AS IS" AND "AS AVAILABLE", WITH ALL FAULTS AND WITHOUT WARRANTY OF ANY KIND, AND KIWI COMPUTER HEREBY DISCLAIMS ALL WARRANTIES AND CONDITIONS WITH RESPECT TO THE SOFTWARE, EITHER EXPRESS, IMPLIED, OR STATUTORY, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES AND/OR CONDITIONS OF MERCHANTABILITY, SATISFACTORY QUALITY, FITNESS FOR A PARTICULAR PURPOSE, ACCURACY, QUIET ENJOYMENT, AND NON-INFRINGEMENT OF THIRD-PARTY RIGHTS. KIWI COMPUTER DOES NOT WARRANT THAT THE FUNCTIONS CONTAINED IN THE SOFTWARE WILL MEET YOUR REQUIREMENTS, THAT THE OPERATION OF THE SOFTWARE WILL BE UNINTERRUPTED OR ERROR-FREE, OR THAT DEFECTS IN THE SOFTWARE WILL BE CORRECTED.

### 11. Limitation of Liability

TO THE EXTENT NOT PROHIBITED BY APPLICABLE LAW, IN NO EVENT SHALL KIWI COMPUTER BE LIABLE FOR PERSONAL INJURY, OR ANY INCIDENTAL, SPECIAL, INDIRECT, OR CONSEQUENTIAL DAMAGES WHATSOEVER, INCLUDING, WITHOUT LIMITATION, DAMAGES FOR LOSS OF PROFITS, CORRUPTION OR LOSS OF DATA, FAILURE TO TRANSMIT OR RECEIVE ANY DATA, BUSINESS INTERRUPTION, OR ANY OTHER COMMERCIAL DAMAGES OR LOSSES, ARISING OUT OF OR RELATED TO YOUR USE OR INABILITY TO USE THE SOFTWARE, HOWEVER CAUSED, REGARDLESS OF THE THEORY OF LIABILITY (CONTRACT, TORT, OR OTHERWISE) AND EVEN IF KIWI COMPUTER HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES. IN NO EVENT SHALL KIWI COMPUTER'S TOTAL LIABILITY TO YOU FOR ALL DAMAGES EXCEED FIFTY DOLLARS ($50.00), REGARDLESS OF WHETHER THE SOFTWARE WAS PROVIDED FREE OF CHARGE.

### 12. Governing Law and Venue

This License will be governed by and construed in accordance with the laws of the Commonwealth of Pennsylvania, excluding its conflict of law principles. You expressly agree that exclusive jurisdiction for any claim or dispute with Kiwi Computer or relating in any way to your use of the Software resides in the state and federal courts located within or nearest to Chester County, Pennsylvania, and you further agree and expressly consent to the exercise of personal jurisdiction in such courts in connection with any such dispute or claim.

### 13. Export Control

You may not use or otherwise export or re-export the Software except as authorized by United States law and the laws of the jurisdiction in which the Software was obtained. In particular, but without limitation, the Software may not be exported or re-exported (a) into any U.S.-embargoed countries or (b) to anyone on the U.S. Treasury Department's Specially Designated Nationals List or the U.S. Department of Commerce Denied Persons List or Entity List. By using the Software, you represent and warrant that you are not located in any such country or on any such list.

### 14. Data Privacy

To Kiwi Computer's knowledge, the Software is not designed to collect or transmit telemetry, usage analytics, or personal information to Kiwi Computer. However, the Software may utilize third-party deployment tools (such as Docker or WSL) which may have their own independent data collection policies. 

### 15. Third-Party and Open-Source Components

Certain components of the Software may be subject to open-source software licenses ("Open-Source Components"). Such Open-Source Components are licensed to you under the terms of their respective applicable open-source license agreements. Nothing in this Agreement restricts, limits, or otherwise affects any rights or obligations you may have, or conditions to which you may be subject, under any applicable open-source licenses for the Open-Source Components.

### 16. No Patent License

Nothing in this Agreement shall be construed as granting, by implication, estoppel, or otherwise, a license to any patents, patent applications, or other patent rights owned or controlled by Kiwi Computer, except to the extent strictly necessary for the internal, non-transferable authorized use of the Software as expressly granted in Section 4.

### 17. No Obligation for Support or Updates

Kiwi Computer is not obligated to provide any maintenance, technical support, bug fixes, updates, upgrades, or new releases for the Software. Kiwi Computer reserves the right to modify, suspend, or discontinue support or development of the Software at any time without notice or liability to you.

### 18. Creator & Founder Attribution

Kiwi Computer was established through the collaborative efforts of Nealuv Tripathi, Rishi Marri, and Abhinav Swaminathan Deepak. While this Agreement governs the Software distributed by Kiwi Computer, nothing herein shall diminish recognition of its founders.

### 19. Severability

If any provision of this Agreement is found to be void, invalid, unenforceable, or illegal by a court of competent jurisdiction, the validity and enforceability of the remaining provisions of this Agreement shall not be affected, and such provision shall be enforced to the maximum extent permissible so as to effect the intent of the parties.

### 20. Entire Agreement

This Agreement constitutes the entire agreement between you and Kiwi Computer relating to the Software and supersedes all prior or contemporaneous understandings, communications, agreements, and representations, whether written or oral, regarding such subject matter.

Copyright © 2026 Kiwi Computer.
All rights reserved.