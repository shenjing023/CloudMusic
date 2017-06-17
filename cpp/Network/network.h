#ifndef NETWORK_H
#define NETWORK_H

#include <QObject>
#include <QVariant>
class QNetworkReply;
class QNetworkAccessManager;

class Network : public QObject
{
    Q_OBJECT
public:
    explicit Network(QObject *parent = 0);
    ~Network();

    Q_INVOKABLE void getUrlResource(QString url,QString params);
    Q_INVOKABLE void getUrlResource2(QString url,QString params);

signals:
    void sig_requestFinish(QVariant bytes);
public slots:
    void slot_requestFinish(QNetworkReply*);

private:
    QNetworkAccessManager *networkManager;
};

#endif // NETWORK_H
