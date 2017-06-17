/*
 * 主要摘自https://segmentfault.com/a/1190000005855574，感谢
*/


#ifndef AUDIODATA_H
#define AUDIODATA_H

#include <QObject>
#include <QJsonDocument>
#include <QJsonArray>
#include <QJsonObject>
#include "libzplay.h"

using namespace libZPlay;

class QTimer;

class AudioData : public QObject
{
    Q_OBJECT
public:
    explicit AudioData(QObject *parent = 0);
    virtual ~AudioData();

    Q_INVOKABLE QString parseMusicInfo(QString path);
    Q_INVOKABLE void playMusic(QString path);
    Q_INVOKABLE void pauseMusic();
    Q_INVOKABLE void resumeMusic();
    Q_INVOKABLE void stopMusic();
    Q_INVOKABLE void setPosition(qint64 ms);
    Q_INVOKABLE void setRate(const int rate);
    Q_INVOKABLE void setPitch(const int pitch);
    Q_INVOKABLE void setTempo(const int tempo);
    Q_INVOKABLE void setCenterCut();
    Q_INVOKABLE void setEq();
    Q_INVOKABLE void setEcho();
    Q_INVOKABLE void setMixChannels();
    Q_INVOKABLE void setVolumn(const int volumn);

    //music pcm data
    Q_PROPERTY(QString pcmData READ pcmData NOTIFY pcmDataChanged)
    QString pcmData()
    {
        QJsonObject root;
        QJsonArray hn;
        for(int i =0;i<257;i++){
            hn.append (pnLeftAmplitude[i]);
        }
        root.insert ("data",hn);
        QJsonDocument doc;
        doc.setObject (root);
        return doc.toJson ();
    }

    Q_INVOKABLE void nextSong();
    Q_INVOKABLE void previousSong();
    Q_INVOKABLE void setPlayMode(const int mode);
    Q_INVOKABLE bool playStatus() const;

signals:
    void sig_playingMusic();
    void sig_playError();
    void sig_positionChanged(qint64 milliseconds);
    void sig_musicInfo(qint64 duration,QString _title,QString album,QString artists);
    void pcmDataChanged();
public slots:
    void refreshData();
private:
    ZPlay *player;
    QTimer *timer;
    int  pnHarmonicNumber[512];
    int  pnHarmonicFreq[257];
    int  pnLeftAmplitude[257];
    int  pnRightAmplitude[257];
    int  pnLeftPhase[257];
    int  pnRightPhase[257];

    int nRate;  //Rate
    int nPitch; //音高
    int nTempo; //播放速度
    int fCenterCut; //消除人声
    int fEq;    //EQ均衡器
    int fEcho;  //回声
    int fMixChannels;   //混合立体声道
    int lVolume;    //左声道音量
    int rVolume;    //右声道音量

    QStringList songList;   //存储播放音乐的列表
    QString currentSong;    //当前播放的音乐
    //播放模式,0顺序播放，1列表循环，2单曲循环，3随机播放
    int playMode;
};

#endif // AUDIODATA_H
