package logic

import (
	"context"
	"database/sql"
	"github.com/pkg/errors"
	"github.com/songsongsongggg/easy-chat/apps/user/models"
	"github.com/songsongsongggg/easy-chat/apps/user/rpc/internal/svc"
	"github.com/songsongsongggg/easy-chat/apps/user/rpc/user"
	"github.com/songsongsongggg/easy-chat/pkg/ctxdata"
	"github.com/songsongsongggg/easy-chat/pkg/encrypt"
	"github.com/songsongsongggg/easy-chat/pkg/wuid"
	"github.com/songsongsongggg/easy-chat/pkg/xerr"
	"github.com/zeromicro/go-zero/core/logx"
	"time"
)

var (
	ErrPhoneIsRegister = xerr.New(xerr.SERVER_COMMON_ERROR, "手机号已经注册过")
)

type RegisterLogic struct {
	ctx    context.Context
	svcCtx *svc.ServiceContext
	logx.Logger
}

func NewRegisterLogic(ctx context.Context, svcCtx *svc.ServiceContext) *RegisterLogic {
	return &RegisterLogic{
		ctx:    ctx,
		svcCtx: svcCtx,
		Logger: logx.WithContext(ctx),
	}
}

func (l *RegisterLogic) Register(in *user.RegisterReq) (*user.RegisterResp, error) {

	// 1. 验证用户是否注册，根据手机号码验证
	userEntity, err := l.svcCtx.UsersModel.FindByPhone(l.ctx, in.Phone)
	if err != nil && err != models.ErrNotFound {
		return nil, errors.Wrapf(xerr.NewDBErr(), "register user by Phone err %v , req %v", err, in.Phone)
	}

	if userEntity != nil {
		return nil, errors.WithStack(ErrPhoneIsRegister)
	}

	// 定义用户数据
	userEntity = &models.Users{
		Id:       wuid.GenUid(l.svcCtx.Config.Mysql.DataSource),
		Avatar:   in.Avatar,
		Nickname: in.Nickname,
		Phone:    in.Phone,
		Sex: sql.NullInt64{
			Int64: int64(in.Sex),
			Valid: true,
		},
	}

	if len(in.Password) > 0 {
		genPassword, err := encrypt.GenPasswordHash([]byte(in.Password))
		if err != nil {
			return nil, err
		}
		userEntity.Password = sql.NullString{
			String: string(genPassword),
			Valid:  true,
		}
	}

	_, err = l.svcCtx.UsersModel.Insert(l.ctx, userEntity)
	if err != nil {
		return nil, err
	}

	// 生成token
	now := time.Now().Unix()
	token, err := ctxdata.GetJwtToken(l.svcCtx.Config.Jwt.AccessSecret, now, l.svcCtx.Config.Jwt.AccessExpire,
		userEntity.Id)
	if err != nil {
		return nil, err
	}

	return &user.RegisterResp{
		Token:  token,
		Expire: now + l.svcCtx.Config.Jwt.AccessExpire,
	}, nil
}
