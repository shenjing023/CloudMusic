#include "audiodata.h"
#include <windows.h>
#include <QDir>
#include <QFileInfoList>
#include <QFileInfo>
#include <QDebug>
#include <QTimer>
#include <QTime>
#include <QCoreApplication>
using namespace libZPlay;
using namespace std;
AudioData::AudioData(QObject *parent) : QObject(parent)
{
    player=CreateZPlay();
    if(player==nullptr)
    {
        qWarning()<<"error:"<<player->GetError();
        exit(0);
    }
    timer=new QTimer();
    timer->setInterval(10);
    connect(timer,SIGNAL(timeout()),this,SLOT(refreshData()));

    nRate=100;
    nPitch=100;
    nTempo=100;
    fCenterCut=0;
    fEq=0;
    fEcho=0;
    fMixChannels=0;
    lVolume=50;
    rVolume=50;

    //libZPlay的官方例子，不知什么作用
    // program some echo efffect
    TEchoEffect effect[2];


    effect[0].nLeftDelay = 1000;
    effect[0].nLeftEchoVolume = 20;
    effect[0].nLeftSrcVolume = 80;
    effect[0].nRightDelay = 500;
    effect[0].nRightEchoVolume = 20;
    effect[0].nRightSrcVolume = 80;

    effect[1].nLeftDelay = 300;
    effect[1].nLeftEchoVolume = 20;
    effect[1].nLeftSrcVolume = 0;
    effect[1].nRightDelay = 300;
    effect[1].nRightEchoVolume = 20;
    effect[1].nRightSrcVolume = 0;

    // set echo effects
    player->SetEchoParam(effect, 2);

    playMode=0;
}

AudioData::~AudioData()
{
    if(nullptr!=player)
        player->Release();
}

bool AudioData::playStatus() const
{
    return currentSong.isEmpty();
}

//解析音乐文件的标签信息，返回一个json格式的字符串
QString AudioData::parseMusicInfo(QString path)
{
    songList.clear();
    path=path.left(path.length()-1);
    QStringList dirList=path.split(",");
    QString temp;
    QString list;list.push_back("{\"list\":[");
    foreach (temp, dirList) {
        temp=temp.right(temp.length()-8);
        QDir dir(temp);
        dir.setNameFilters(QStringList() << "*.mp3" << "*.flac" << "*.wav");
        QFileInfoList fileList=dir.entryInfoList();
        QFileInfo fileInfo;

        foreach (fileInfo, fileList) {
            TID3InfoEx id3_info;
            QString tmpList;
            //这两种方法都会出现中文乱码
            //const char *str=fileInfo.absoluteFilePath().toStdString().c_str();
            //const char *str=fileInfo.absoluteFilePath().toLatin1().data();
            //如果直接使用LoadFileID3Ex函数，会得不到时长信息
            if(player->OpenFile((const char*) fileInfo.absoluteFilePath().toLocal8Bit(),sfAutodetect))
                if(player->LoadID3Ex(&id3_info,1))
                {
                    tmpList.append("{");//qDebug()<<QString(id3_info.Title);
                    tmpList.append("\"title\":\""+QString::fromLocal8Bit(id3_info.Title)+"\",");  //音乐标题
                    tmpList.push_back("\"artists\":\""+QString::fromLocal8Bit(id3_info.Artist)+"\",");//歌手
                    //                tmpList.append("\"artists\":\"");
                    //                tmpList.append(id3_info.Artist);
                    //                tmpList.append("\",");
                    tmpList.append("\"album\":\""+QString::fromLocal8Bit(id3_info.Album)+"\",");//专辑

                    // get stream info,获取时长信息
                    TStreamInfo pInfo;
                    player->GetStreamInfo(&pInfo);
                    unsigned int sec=pInfo.Length.sec;
                    QString minute=sec/60>=10?QString::number(sec/60):"0"+QString::number(sec/60);
                    QString secs=sec%60>=10?QString::number(sec%60):"0"+QString::number(sec%60);
                    tmpList.append("\"duration\":\""+QString(minute+":"+secs)+"\",");

                    if(fileInfo.size()<1024*1024)    //KB
                        tmpList.append("\"size\":\""+QString(QString::number(fileInfo.size()/1024.0,'f',1)+"KB")+"\",");
                    else    //MB
                        tmpList.push_back("\"size\":\""+QString(QString::number((float)fileInfo.size()/(1024*1024),'f',1)+"MB")+"\",");

                    tmpList.append("\"path\":\""+fileInfo.absoluteFilePath()+"\"");
                    tmpList.append("},");
                    list.append(tmpList);
                    //                if(songList.length()==0)
                    songList.append(fileInfo.absoluteFilePath());
                    //            printf("Title:   %s\r\n", id3_info.Title);
                    //            printf("Artist:  %s\r\n", id3_info.Artist);
                    //            printf("Album:   %s\r\n", id3_info.Album);
                    //            printf("Year:    %s\r\n", id3_info.Year);
                    //            printf("Comment: %s\r\n", id3_info.Comment);
                    //            printf("Genre:   %s\r\n", id3_info.Genre);
                    //            printf("Track:   %s\r\n", id3_info.TrackNum);

                    //            printf("Artist1 :  %s\r\n", id3_info.AlbumArtist );
                    //            printf("Composer:  %s\r\n", id3_info.Composer );
                    //            printf("Original:  %s\r\n", id3_info.OriginalArtist );
                    //            printf("Copyright: %s\r\n", id3_info.Copyright );
                    //            printf("URL:       %s\r\n", id3_info.URL );
                    //            printf("Encoder:   %s\r\n", id3_info.Encoder );
                    //            printf("Publisher: %s\r\n", id3_info.Publisher );
                    //            printf("BPM:       %u\r\n", id3_info.BPM);
                    //            printf("MIME:      %s\r\n", id3_info.Picture.MIMEType);
                    //            printf("TYPE:      %u\r\n", id3_info.Picture.PictureType);
                    //            printf("Desc:      %s\r\n", id3_info.Picture.Description);
                    //printf("Size:      %u\r\n\r\n", id3_info.Picture.PictureDataSize);
                }
                else
                {
                    printf("No ID3 data:%s\r\n\r\n",player->GetError());
                }
            else
            {

            }
        }
    }
    list=list.left(list.length()-1);
    list.append("]}");
    //qDebug()<<list;
    return list;
}

void AudioData::playMusic(QString path)
{
    if(player->OpenFile((const char*) path.toLocal8Bit(),sfAutodetect)==0)
    {

    }
    else
    {
        TStreamInfo pInfo;
        player->GetStreamInfo(&pInfo);
        TID3InfoEx id3_info;
        if(player->LoadID3Ex(&id3_info,1))
        {
            sig_musicInfo(pInfo.Length.ms,QString::fromLocal8Bit(id3_info.Title),QString::fromLocal8Bit(id3_info.Album),QString::fromLocal8Bit(id3_info.Artist));
            player->Play();
            timer->start();
            currentSong=path;
        }
    }

}

void AudioData::nextSong()
{
    int index=songList.indexOf(currentSong);
    switch (playMode) {
    //顺序播放
    case 0:
        if(index==songList.length()-1)  //列表的最后
        {
            stopMusic();
            return;
        }
        else
            ++index;
        break;
     //列表循环
    case 1:
        if(index==songList.length()-1)  //列表的最后
        {
            //从头开始
            index=0;
        }
        else
            ++index;
        break;
     //单曲循环
    case 2:
        break;
    //随机播放
    case 3:
        qsrand(QTime(0,0,0).secsTo(QTime::currentTime()));
        index=qrand()%songList.length();
        break;
    default:
        break;
    }
    playMusic(songList.at(index));
}

void AudioData::previousSong()
{
    int index=songList.indexOf(currentSong);
    switch (playMode) {
    //顺序播放
    case 0:
        if(index==0)  //列表的最后
        {
            index=songList.length()-1;
        }
        else
            --index;
        break;
     //列表循环
    case 1:
        if(index==0)  //列表的最后
        {
            index=songList.length()-1;
        }
        else
            --index;
        break;
     //单曲循环
    case 2:
        break;
    //随机播放
    case 3:
        qsrand(QTime(0,0,0).secsTo(QTime::currentTime()));
        index=qrand()%songList.length();
        break;
    default:
        break;
    }
    playMusic(songList.at(index));
}

void AudioData::setPlayMode(const int mode)
{
    playMode=mode;
}

void AudioData::pauseMusic()
{
    player->Pause();
    timer->stop();qDebug()<<"stop1";
}

void AudioData::resumeMusic()
{
    player->Resume();
    timer->start();
}

void AudioData::stopMusic()
{
    player->Stop();
    timer->stop();qDebug()<<"stop";
}

void AudioData::setPosition(qint64 ms)
{
    TStreamTime pTime;
    pTime.ms = ms;
    player->Seek(tfMillisecond,&pTime,smFromBeginning);
}


void AudioData::refreshData()
{
    TStreamTime pos;
    player->GetPosition(&pos);
    int FFTPoints = player->GetFFTGraphParam(gpFFTPoints);
    player->GetFFTData(FFTPoints,fwTriangular,
                       pnHarmonicNumber,
                       pnHarmonicFreq,
                       pnLeftAmplitude,
                       pnRightAmplitude,
                       pnLeftPhase,
                       pnRightPhase);
    sig_positionChanged(pos.ms);
    pcmDataChanged();
}

void AudioData::setRate(const int rate)
{
    nRate=rate;
    player->SetRate(rate);
}

void AudioData::setPitch(const int pitch)
{
    nPitch=pitch;
    player->SetPitch(pitch);
}

void AudioData::setTempo(const int tempo)
{
    nTempo=tempo;
    player->SetTempo(tempo);
}

void AudioData::setCenterCut()
{
    fCenterCut=!fCenterCut;
    player->StereoCut(fCenterCut,0,0);
}

void AudioData::setEq()
{
    fEq = !fEq;

    // enable or disable equalizer
    player->EnableEqualizer(fEq);

    if(fEq)
    {
        player->SetEqualizerBandGain(0, 10000); // boost low frequenfy band for 10 dB
        player->SetEqualizerBandGain(1, 2000); //boost for 2 dB
        player->SetEqualizerBandGain(2, -8000); // cut this band for 8 dB

        player->SetEqualizerBandGain(5, 8000); // boost this band for 8 dB
        player->SetEqualizerBandGain(6, 8000); // boost this band for 8 dB
    }
}

void AudioData::setEcho()
{
    fEcho = !fEcho;
    player->EnableEcho(fEcho);
}

void AudioData::setMixChannels()
{
    // mix stereo channels to mono
    fMixChannels = !fMixChannels;
    player->MixChannels(fMixChannels, 50, 50);
}

void AudioData::setVolumn(const int volumn)
{
    lVolume=volumn;
    rVolume=volumn;
    player->SetMasterVolume(volumn, volumn);
}

