# TASK-5: Problem Solving & Best Practices

---

## 1. Langkah-langkah Menemukan Root Cause di Production

### a. Penurunan Success Rate (Too Many 4xx)

**Langkah-langkah:**

- **Set dan cek alerting**
  - Memastikan bahwa ada penurunan request yang terjadi. Pastikan telah melakukan set Alerting dengan metrics request atau traffic.
  - Alert bisa berupa alert metrics ataupun alert yang bersumber dari logs access ataupun logs aplikasi.

- **Cek pada monitoring**
  - Kita dapat melakukan pengecekan pada datadog, grafana ataupun ELK stack.
  - Cari dashboard yang relate dengan response code 4xx.

- **Cek log access:**
  - Lihat request log request dari reverse proxy (NGINX, ALB) maupun aplikasi. Kita dapat melihatnya didalam grafana ataupun datadog.
  - Identifikasi pattern itu terjadi pada URI atau IP mana yang menyebabkan 4xx.

- **Lakukan error tracing & debugging:**
  - Cari traceID yang relate dengan log yang relate dengan error 4xx.
  - periksa payload yang dikirimkan user atau client apakah sudah sesuai atau memang ada kesalahan dalam pengiriman payload request.

- **Cek apakah ada deployment terbaru:**
  - validasi apakah ada perubahan atau deployment baru yang mengakibatkan impact tersebut. jika ada, lakukan rollback ke previous version yang mana itu adalah versi stable.

---

### b. Downtime / Platform Tidak Dapat Diakses (5xx)

**Langkah-langkah:**

- **Cek Alert:**
  - Cek alert dari monitoring tools dan status endpoint. biasanya kita melakukan define endpoint /healthz sebagai acuan service sedang berjalan

- **Cek Resource:**
  - Cek status pod pada service yang bermasalah. jika pod mengalami crashloopbackoff, kita coba cek apakah ada deployment versi terbaru atau tidak.
  - pastikan komunikasi antar service tidak terjadi masalah atau koneksi ke db, rabbitmq, kafka ataupun redis tidak ada masalah.

- **Check log:**
  - indentifikasi apakah ada trend error yang terjadi dari log. jika relate dengan resource service coba cari tahu terlebih dahulu lognya.
  - kumpulkan log yang relate dengan error tersebut.

- **Lakukan Rollback:**
  - Jika deployment menyebabkan error 5xx atau panic, lakukan rollback ke versi sebelumnya.
  - Aktifkan failover atau recovery plan sesuai SOP.
  - gunakan pod disruption budget jika mengalami lagi. agar meminimalisir kejadian tersebut. jika kita sudah menggunakannya, kita dapat langsung action tanpa mengalami downtime.

- **Buat Incident Report:**
  - pastikan menulis seluruh aktifitas yang kita lakukan didalam incident report ataupun Post Mortem. Undang developer ataupun engineer terkait agar ikut serta dalam debugging serta dalam melakukan perbaikan.

---

## 2. Strategi dalam Mengerjakan Task Besar

**Langkah-langkah:**

1. **Breakdown & define task**
   - buat task ataupun todo list yang akan dikerjakan
2. **Buat Prioritas**
   - urutkan task berdasarkan prioritas. kita dapat membagi berdasarkan berat atau tidak nya task tersebut.
3. **Buat timeline pekerjaan**
   - Buat timeline dengan project timeline seperti jira. kita dapat memasukan task yang kita define menjadi satu ticket. dari prioritas tersebut kita dapat menentukan story point dari task/ticket yang akan dikerjakan.
4. **Daily update & sync**
   - Lakukan secara daily update & sync seluruh task yang dikerjakan.
5. **Trial error & review**
   - Sebelum menyelesaikan atau deploy sebuah task pastikan sudah melakukan trial error dan mencatatnya.
   - Lakukan request review dari tim agar mendapatkan masukan dari tim.
6. **Documentation**
   - Pastikan membuat dokumentasi dari hasil catatan trial error yang kita lakukan. dan jangan lupa melakukan sharing agar tim kita mengerti serta paham apa yang kita kerjakan.

---

## 3. Berapa jumlah subnet untuk VPC di Production?

- **Pastikan menggunakan HA**
  - kita perlu menggunakan 3 subnet untuk multiple zone. jika kita membagi 2 subnet menjadi public dan private, kita perlu definisikan tiap subnet tersebut 3 subnet sesuaikan dengan availability zone biasanya a,b, dan c.

**Tipe subnet:**
- Public Subnet: Untuk ALB atau NLB, bastion atau jump serber, dan NAT Gateway.
- Private Subnet: Untuk aplikasi, database, cached dan aplikasi atau tool yang relate dengan cluster kita.

---

## 4. Optimasi Biaya di Public Cloud

**Hal-hal yang dilakukan:**
- Gunakan instance sesuai workload atau kebutuhan
- Implementasi auto scaling berdasarkan traffic.
- Untuk service yang bukan termasuk critical kita dapat menggunakan spot instance.
- Lakukan shutdown temp diwaktu malam atau di weekend pada non-critical environment.
- Implementasi lifecycle policy pada S3.
- Pastikan koneksi antar service atau ke DB ataupun cache menggunakan private access.
- Jika menggunakan S3, pastikan menggunakan vpc endpoint agar komunikasi secara private.
- Jika menggunakan ECR, pastikan juga menggunakan vpc endpoint agar komunikasi secara private.
- Lakukan retention policy pada log server atau centralized log.
- Lakukan Audit resource secara berkala. minimal 3 bulan sekali melakukan hal tersebut. agar dapat mereview semua resource yang dipakai.*Inisiatif 
- Jika menggunakan WAF, gak lebih dari 1500 WCU. agar tidak terkena biaya tambahan pada WAF AWS.
---

## 5. Security di Public Cloud Infrastructure

- **Access**
  - Gunakan IAM user untuk mengakses kedalam public cloud. pastikan 1 user 1 account. dan tidak menggunakan sharing user.
  - Aktifkan MFA untuk semua user yang dicreate.
  - Aktifkan SSO pada semua tools yang digunakan.

- **Application Security**
  - Gunakan WAF, rate limiting
  - Pastikan ada authentication dilevel api gateway.
  - Semua request dan komunikasi  terenkripsi(HTTPS, TLS 1.2/1.3).
  - Impelementasi SIEM agar dapat menjadi source of truth dari semua resource yang kita miliki.
  - Jika memerluka interkoneksi secara public, pastikan menggunakan VPN access ataupun Whitelist access.
  - Pastikan komunikasi antar service secara private dan tidak menggunakan public access.

- **VPN Access**
  - Setiap access kedalam service atau environment production wajib menggunakan vpn.
  - Pastikan vpn tersebut menggunakan MFA

- **Database Security**
  - Batasi akses hanya dari subnet yang terpecaya.
  - Gunakan rotation otomatis untuk credentials atau password. Lakukan rotation secara rutin minimal 3 bulan sekali.

- **Credential & Secrets**
  - Gunakan Vault atau secret manager untuk memanage semua credential. jangan lakukan penyimpanan credential didalam repo
  - gunakan sops encryption, bila akan menyimpan file secret didalam repo
  - Audit dan rotate secrets tersebut secara berkala
  - Jangan menyimpan credential pada CI/CD platform. pastikan CI/CD dapat berkomunikasi pada vault untuk mendapatkan credential. di gitlab-ci kita dapat menggunakan JWT TOKEN ataupun diJenkins dapat menggunakan APPROLE yang mana hanya pipeline di repo yang ter-Authorized yang bisa komunikasi ke vault kita.

---

