import request from '@/utils/request'

export function preview(name) {
    return request({
        url: '/system/generate/preview/' + name,
        method: 'get'
    })
}
export function getTableList(params) {
    return request({
        url: '/system/generate/list',
        method: 'get',
        params: params
    })
}