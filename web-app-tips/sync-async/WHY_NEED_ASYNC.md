# どういうときに非同期処理が必要か?

長時間かかる処理を同期処理で行っていた場合

この点について取り上げる。どうなるか。
処理が終わるまでウェブアプリケーションサーバは
クライアント側にレスポンスを返さない状態になる。

例として、sleep 120という処理をRails controllerに挟む。

```rb
def index
  sleep 120
  render json: {status: 'ok', message: 'hello world!'}
end
```

このController, actionを呼び出すとどうなるかは
予想し易いだろう。120秒ほど、クライアント側で
処理待ち状態になる。
