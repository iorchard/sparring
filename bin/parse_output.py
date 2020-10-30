import xml.etree.ElementTree as ET
tree = ET.parse('../funcbot/output/output.xml')
root = tree.getroot()

print(root.tag)
print(root.attrib)

for child in root:
    print(child.tag)

for s in root.iter('suite'):
    suite_name = s.get('name')
    if suite_name is not None:
        print("Suite: {}".format(suite_name))
        for t in s.findall('test'):
            test_name = t.get('name')
            print("\tTest: {}".format(test_name))
