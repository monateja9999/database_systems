import math

# Spirograph parameters
R = 36  # Scale factor for the big circle
r = 9 # Scale factor for the small circle
a = 30  # Distance of the pen point from the center of the small circle

# Adjust these values as needed
nRev = 8 # Number of revolutions
center_lat = 34.0205743
center_long = -118.2854449
scaling_factor = 50000
# Initialize KML content
kml_content = f"""<?xml version="1.0" encoding="UTF-8"?>
<kml xmlns="http://www.opengis.net/kml/2.2">
<Document>
    <name>Spirograph</name>
    <Placemark>
        <name>Spirograph</name>
        <Style>
            <LineStyle>
                <color>ff0000ff</color>
                <width>4</width>
            </LineStyle>
        </Style>
        <LineString>
            <coordinates>
"""

# Calculate Spirograph coordinates and add them to the KML content
for t in range(int(math.pi * nRev * 100)):
    t /= 100.0
    x = (R + r) * math.cos((r / R) * t) - a * math.cos((1 + r / R) * t)
    y = (R + r) * math.sin((r / R) * t) - a * math.sin((1 + r / R) * t)
    x1 = x/scaling_factor + center_long
    y1 = y/scaling_factor + center_lat
    kml_content += f"{x1},{y1},0\n"

# Complete KML content
kml_content += """</coordinates>
        </LineString>

    </Placemark>
    <Style id="z1">
    <IconStyle><Icon><href>http://www.google.com/intl/en_us/mapfiles/ms/micons/blue-dot.png</href></Icon></IconStyle>
    </Style>
    <Placemark><name>TOMMY TROJAN</name>
        <styleUrl>#z1</styleUrl><Point><coordinates>-118.2854449,34.0205743</coordinates></Point>
    </Placemark>
</Document>
</kml>
"""

# Save the KML content to a file
with open("spiro.kml", "w") as kml_file:
    kml_file.write(kml_content)

print("KML file 'spiro.kml' has been generated.")
