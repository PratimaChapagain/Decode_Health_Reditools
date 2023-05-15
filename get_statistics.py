import sys
import os

REDI_FOLDER = "/mnt/iquityazurefileshare1/Test/MiniTestData_HCvMN/redioutput"

folders = os.listdir(REDI_FOLDER)


def getDistro(lines):
    s = {}
    for i in 'ACGT':
        for j in 'ACGT':
            if i != j:
                s[i+j] = 0
    n = {}
    x = 0
    for i in 'ACGT':
        n[i] = x
        x += 1
    all = 0
    for i in lines:
        sub = i[7].split()[0]
        nuc = eval(i[6])
        nv = nuc[n[sub[1]]]
        s[sub] += nv
        all += nv
    d = {}
    for i in s:
        try:
            v = (s[i]/float(all))*100
        except:
            v = 0.0
        d[i] = (s[i], all, v)
    return d


for folder in folders:
    print(folder)
    editing_path = "%s/%s/parallel/output" % (REDI_FOLDER, folder)
    if not os.path.exists('%s/candidates.rmsk.txt' % editing_path):
        print('candidates.rmsk.txt file not found.')
        continue

    if not os.path.exists('%s/editing_statistics.txt' % editing_path):
        print("Reading candidates...")
        alu, nonalu, nonrep, kn = [], [], [], 0
        f = open('%s/candidates.rmsk.txt' % editing_path)
        for i in f:
            if i.startswith('Reg'):
                continue
            l = (i.strip()).split('\t')
            # if l[18] == 'ed':
            # kn += 1
            if l[14] == 'SINE' and l[15][:3] == 'Alu':
                alu.append(l)
            elif l[14] != '-' and l[15][:3] != 'Alu':
                nonalu.append(l)
            elif l[14] == '-' and l[15] == '-':
                nonrep.append(l)
        f.close()

        alust = getDistro(alu)
        nonalust = getDistro(nonalu)
        nonrepst = getDistro(nonrep)
        all = getDistro(alu+nonalu+nonrep)

        print("Outputting editing statistics to")
        print('%s/editing_statistics.txt' % editing_path)

        f = open('%s/editing_statistics.txt' % editing_path, 'w')
        h = ['SubType', 'ALU', 'REPnonALU', 'NONREP', 'ALL']
        f.write('\t'.join(h)+'\n')
        for i in alust:
            r = [i, alust[i][2], nonalust[i][2], nonrepst[i][2], all[i][2]]
            r = [str(x) for x in r]
            f.write('\t'.join(r)+'\n')
        f.close()
