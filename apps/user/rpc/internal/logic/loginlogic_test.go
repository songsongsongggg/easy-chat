package logic

import (
	"github.com/songsongsongggg/easy-chat/apps/user/rpc/internal/config"
	"github.com/songsongsongggg/easy-chat/apps/user/rpc/internal/svc"
	"github.com/zeromicro/go-zero/core/conf"
)

var svcCtx *svc.ServiceContext

func init() {
	var c config.Config
	conf.MustLoad("../../etc/dev/user.yaml", &c)
	svcCtx = svc.NewServiceContext(c)
}
