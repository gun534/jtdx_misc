# �͂��߂�
���̃��|�W�g����Raspberry Pi4��Ubuntu Server 20.04����ꂽ��AJDTX�𓮂����悤�ɂ��邽�߂̊��\�z�̂��߂̕⏕�t�@�C���Q�ł��B

# �g����
RaspberryPi Imager��microSD��Ubuntu Sever 20.04����������ŋN���B
�R�}���h���C���Ń��O�C�����s������Ƀl�b�g���[�N�Ɍq�����Ԃɂ��Ă��炱�̃��|�W�g����clone���܂��B

# �L��LAN�ݒ��
�L��LAN���Œ�IP�A�h���X�Őݒ肷��ꍇ�́A99_config.yaml�̒��ɋL�q���Ă���IP�A�h���X�����蓖�Ă����A�h���X�ɏ���������/etc/netplan/�ɔz�u���܂��B
�z�u������A�ȉ��Őݒ�𔽉f���܂��B

```
sudo netplan apply
```

# JTDX�C���X�g�[��
jtdx_install.sh�Ɏ��s������t�^���܂��B

```
chown 705 jtdx_install.sh
```

���̌�Ajtdx_install.sh�����s���܂��B

sudo���S�����̂ŁA

```
./jtdx_install.sh [���[�U�[��] [root �p�X���[�h]
```

�Ƃ��܂��B
