import type { NextApiRequest, NextApiResponse } from 'next'
import deploymentBadgeHandler from 'deployment-badge'
import { DEPLOYMENTS_URL } from '../../src/types/constants'

const handler = async (req: NextApiRequest, res: NextApiResponse): Promise<void> => {
  await deploymentBadgeHandler(req, res, { deploymentsUrl: DEPLOYMENTS_URL, namedLogo: 'vercel' })
}

export default handler
