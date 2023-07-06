import request from '@/utils/request'

export function fetchNote(params) {
    return request({
        url: '/system/note/list',
        method: 'get',
        params
    })
}


export function deleteNote(data) {
    return request({
        url: '/system/note/delete',
        method: 'delete',
        data
    })
}