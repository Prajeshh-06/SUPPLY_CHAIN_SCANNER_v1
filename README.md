Supply Chain Risk Scanner (SCA Utility) V1

Goal

DepGuard is an SCA utility we whipped up for the club. The main goal was to stop dealing with those huge, noisy vulnerability reports. It just flags High and Critical risks in our project dependencies, so we know exactly what to fix first and can actually prioritize supply chain threats.

How it Works:
How's it work? Simple. The main script just wraps Grype, a legit vulnerability scanner.
Grype catalogs all packages installed in the target directory (like your big old node_modules folder).
The script uses a resilient Extended Regex filter to strip out all the useless Low/Medium noise, showing only the highest severity alerts.

Setup and Known Quirks:
To get going, you'll need two things:
Tools: Bash and Grype (grype-bin via AUR).

Dependencies are mandatory. I learned this the hard way: the scanner only works if you've already run npm install (or whatever your package manager is) on the target project. If the vulnerable files aren't physically on the disk, Grype can't flag them!

Usage:
Make the script executable: chmod +x scan.sh
Run, passing the project directory root:
./scan.sh /path/to/your/project

