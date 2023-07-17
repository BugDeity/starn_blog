import request from '@/utils/request'
export function featchPhotoAlbum() {
    return request({
        url: '/v1/photoAlbum/',
        method: 'get'
    })
}

export function featchPhoto(params) {
    return request({
        url: '/v1/photo/',
        method: 'get',
        params: params
    })
}